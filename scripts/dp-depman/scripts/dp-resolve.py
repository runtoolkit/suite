#!/usr/bin/env python3
"""
dp-resolve.py — Datapack Dependency Resolver
Reads dependency declarations from .depends/<dep_id>.json files.
Falls back to legacy datapack_depends.json if .depends/ is absent.

Source:  GitHub Releases (prod) or Git Submodule (dev)
Output:  Separate ZIPs or single merged ZIP
"""

import argparse
import hashlib
import os
import re
import shutil
import subprocess
import sys
import urllib.request
import zipfile
from pathlib import Path

# Import shared helpers
sys.path.insert(0, str(Path(__file__).parent))
from _dp_common import (
    CACHE_DIR, DEPENDS_DIR, LOCK_FILE, OUTPUT_DIR, SUBMODULE_DIR,
    load_manifest, load_all_deps, load_lock, save_lock,
    log, warn, die,
)

# ─── Version comparison ───────────────────────────────────────────────────────

def parse_version(v: str) -> tuple[int, ...]:
    v = v.lstrip("v")
    parts = re.split(r"[.\-]", v)
    result = []
    for p in parts:
        try:
            result.append(int(p))
        except ValueError:
            pass
    return tuple(result)

def version_matches(version: str, constraint: str) -> bool:
    """
    Supported constraint formats:
      "1.2.3"    → exact match
      ">=1.2.0"  → minimum version
      "1.2.x"    → wildcard patch
      "^1.2.0"   → major fixed
      "~1.2.0"   → major+minor fixed
    """
    version = version.lstrip("v")
    v = parse_version(version)

    if re.match(r"^\d+\.\d+(\.\d+)*$", constraint):
        return v == parse_version(constraint)
    if constraint.startswith(">="):
        return v >= parse_version(constraint[2:])
    if constraint.startswith("<="):
        return v <= parse_version(constraint[2:])
    if constraint.startswith(">") and not constraint.startswith(">="):
        return v > parse_version(constraint[1:])
    if constraint.startswith("<") and not constraint.startswith("<="):
        return v < parse_version(constraint[1:])
    if re.match(r"^\d+\.\d+\.x$", constraint):
        base = parse_version(constraint[:-2])
        return v[:2] == base[:2]
    if constraint.startswith("^"):
        base = parse_version(constraint[1:])
        return v[0] == base[0] and v >= base
    if constraint.startswith("~"):
        base = parse_version(constraint[1:])
        return v[:2] == base[:2] and v >= base

    raise ValueError(f"Unsupported constraint format: '{constraint}'")

# ─── GitHub Releases resolution ───────────────────────────────────────────────

def fetch_github_releases(owner: str, repo: str, token: str | None) -> list[dict]:
    import json
    url = f"https://api.github.com/repos/{owner}/{repo}/releases"
    req = urllib.request.Request(url)
    req.add_header("Accept", "application/vnd.github+json")
    req.add_header("X-GitHub-Api-Version", "2022-11-28")
    if token:
        req.add_header("Authorization", f"Bearer {token}")
    try:
        with urllib.request.urlopen(req, timeout=15) as resp:
            return json.loads(resp.read())
    except urllib.error.HTTPError as e:
        die(f"GitHub API error ({owner}/{repo}): {e.code} {e.reason}")
    except urllib.error.URLError as e:
        die(f"Network error ({owner}/{repo}): {e.reason}")

def resolve_github(dep_id: str, dep_cfg: dict, token: str | None) -> dict:
    repo         = dep_cfg["repo"]
    owner, repo_name = repo.split("/", 1)
    constraint   = dep_cfg["version"]
    wanted_asset = dep_cfg.get("asset")

    log(f"Checking GitHub releases: {repo}")
    releases = fetch_github_releases(owner, repo_name, token)

    candidates = []
    for rel in releases:
        tag = rel.get("tag_name", "")
        ver = tag.lstrip("v")
        try:
            if version_matches(ver, constraint):
                candidates.append((ver, rel))
        except ValueError as e:
            warn(f"  {tag}: {e}")

    if not candidates:
        die(f"[{dep_id}] No compatible release found (constraint: {constraint})")

    candidates.sort(key=lambda x: parse_version(x[0]), reverse=True)
    chosen_ver, chosen_rel = candidates[0]
    log(f"  → {repo} v{chosen_ver} selected")

    assets = chosen_rel.get("assets", [])
    if wanted_asset:
        asset = next((a for a in assets if a["name"] == wanted_asset), None)
        if not asset:
            die(f"[{dep_id}] Asset '{wanted_asset}' not found in v{chosen_ver}")
    else:
        asset = next((a for a in assets if a["name"].endswith(".zip")), None)
        if not asset:
            die(f"[{dep_id}] No ZIP asset found in v{chosen_ver}")

    return {
        "source":       "github",
        "repo":         repo,
        "version":      chosen_ver,
        "asset_name":   asset["name"],
        "download_url": asset["browser_download_url"],
        "sha256":       None,
    }

def download_asset(url: str, dest: Path, token: str | None) -> str:
    dest.parent.mkdir(parents=True, exist_ok=True)
    req = urllib.request.Request(url)
    if token:
        req.add_header("Authorization", f"Bearer {token}")
    log(f"  Downloading: {url}")
    h = hashlib.sha256()
    with urllib.request.urlopen(req, timeout=60) as resp, open(dest, "wb") as f:
        while chunk := resp.read(65536):
            h.update(chunk)
            f.write(chunk)
    return h.hexdigest()

# ─── Submodule resolution ─────────────────────────────────────────────────────

def resolve_submodule(dep_id: str, dep_cfg: dict, root: Path) -> dict:
    rel_path = dep_cfg.get("path", str(SUBMODULE_DIR / dep_id))
    abs_path = root / rel_path

    if not abs_path.exists():
        die(
            f"[{dep_id}] Submodule directory not found: {rel_path}\n"
            f"  Run: git submodule add <url> {rel_path}"
        )

    # Detect version: .depends/manifest.json → datapack_depends.json → pack.mcmeta
    detected_ver = "unknown"
    for candidate in [
        abs_path / DEPENDS_DIR / "manifest.json",
        abs_path / "datapack_depends.json",
        abs_path / "pack.mcmeta",
    ]:
        if not candidate.exists():
            continue
        try:
            import json
            with open(candidate) as f:
                data = json.load(f)
            # manifest.json and datapack_depends.json use "version" directly
            # pack.mcmeta nests it under "pack"
            ver = data.get("version") or data.get("pack", {}).get("version")
            if ver:
                detected_ver = str(ver)
                break
        except Exception:
            continue

    constraint = dep_cfg.get("version", "*")
    if constraint != "*" and detected_ver != "unknown":
        try:
            if not version_matches(detected_ver, constraint):
                die(
                    f"[{dep_id}] Version mismatch: "
                    f"submodule v{detected_ver} does not satisfy '{constraint}'\n"
                    f"  Update: git submodule update --remote {rel_path}"
                )
        except ValueError as e:
            warn(f"[{dep_id}] Constraint check skipped: {e}")

    log(f"  → {dep_id} submodule v{detected_ver} ({rel_path})")
    return {"source": "submodule", "path": rel_path, "version": detected_ver}

# ─── Dependency resolution ────────────────────────────────────────────────────

def resolve_all(deps: dict, root: Path, mode: str, token: str | None) -> dict:
    """
    mode: "prod" → GitHub releases
          "dev"  → submodule
          "auto" → per-dep source field
    """
    if not deps:
        log("No dependencies declared.")
        return {}

    results = {}
    for dep_id, dep_cfg in deps.items():
        if isinstance(dep_cfg, str):
            dep_cfg = {"source": "auto", "version": dep_cfg}

        source         = dep_cfg.get("source", "auto")
        effective_mode = mode if mode != "auto" else (
            source if source in ("github", "submodule") else "prod"
        )

        if effective_mode == "prod" or source == "github":
            if "repo" not in dep_cfg:
                die(f"[{dep_id}] Missing 'repo' field (required for prod/github)")
            info = resolve_github(dep_id, dep_cfg, token)
        else:
            info = resolve_submodule(dep_id, dep_cfg, root)

        results[dep_id] = info

    return results

# ─── ZIP operations ───────────────────────────────────────────────────────────

def get_dep_zip(dep_id: str, info: dict, root: Path, token: str | None) -> Path:
    """Return the dependency ZIP (from cache or download/pack)."""
    if info["source"] == "submodule":
        src       = root / info["path"]
        cache_zip = CACHE_DIR / f"{dep_id}-{info['version']}-submodule.zip"
        cache_zip.parent.mkdir(parents=True, exist_ok=True)
        with zipfile.ZipFile(cache_zip, "w", zipfile.ZIP_DEFLATED) as zf:
            for file in src.rglob("*"):
                if file.is_file():
                    zf.write(file, file.relative_to(src))
        return cache_zip
    else:
        cache_zip = CACHE_DIR / f"{dep_id}-{info['version']}-{info['asset_name']}"
        cache_zip.parent.mkdir(parents=True, exist_ok=True)
        if not cache_zip.exists():
            sha          = download_asset(info["download_url"], cache_zip, token)
            info["sha256"] = sha
            log(f"  SHA-256: {sha}")
        else:
            log(f"  Using cached: {cache_zip.name}")
        return cache_zip

def _get_pack_root(manifest: dict, root: Path) -> Path:
    """
    Locate the directory containing pack.mcmeta.
    Priority: manifest 'pack_root' field → search one level deep → root.
    """
    if "pack_root" in manifest:
        return root / manifest["pack_root"]

    for candidate in [root] + [p for p in root.iterdir() if p.is_dir()]:
        if (candidate / "pack.mcmeta").exists():
            if candidate != root:
                log(f"Pack root detected: {candidate.relative_to(root)}/")
            return candidate

    return root

def _should_exclude(file: Path, pack_root: Path) -> bool:
    """Only pack.mcmeta and data/ belong in the output ZIP."""
    parts = file.relative_to(pack_root).parts
    return parts[0] not in {"data", "pack.mcmeta"}

def build_separate_zips(manifest: dict, resolved: dict, root: Path, token: str | None):
    out = root / OUTPUT_DIR
    out.mkdir(parents=True, exist_ok=True)

    for dep_id, info in resolved.items():
        dep_zip = get_dep_zip(dep_id, info, root, token)
        dest    = out / f"{dep_id}-{info['version']}.zip"
        shutil.copy2(dep_zip, dest)
        log(f"  Dep ZIP: {dest.name}")

    pack_root     = _get_pack_root(manifest, root)
    pack_zip_path = out / f"{manifest['id']}-{manifest['version']}.zip"
    with zipfile.ZipFile(pack_zip_path, "w", zipfile.ZIP_DEFLATED) as zf:
        for file in pack_root.rglob("*"):
            if file.is_file() and not _should_exclude(file, pack_root):
                zf.write(file, file.relative_to(pack_root))
    log(f"Main pack: {pack_zip_path.name}")

def build_merged_zip(manifest: dict, resolved: dict, root: Path, token: str | None):
    out = root / OUTPUT_DIR
    out.mkdir(parents=True, exist_ok=True)

    merged_path = out / f"{manifest['id']}-{manifest['version']}-merged.zip"
    seen: dict[str, str] = {}
    conflicts = []

    with zipfile.ZipFile(merged_path, "w", zipfile.ZIP_DEFLATED) as zf:
        for dep_id, info in resolved.items():
            with zipfile.ZipFile(get_dep_zip(dep_id, info, root, token)) as dz:
                for name in dz.namelist():
                    if name in seen:
                        conflicts.append(f"  CONFLICT: '{name}' ({seen[name]} ↔ {dep_id})")
                    else:
                        seen[name] = dep_id
                    zf.writestr(name, dz.read(name))

        pack_root = _get_pack_root(manifest, root)
        for file in pack_root.rglob("*"):
            if file.is_file() and not _should_exclude(file, pack_root):
                arc = str(file.relative_to(pack_root))
                seen[arc] = f"{manifest['id']} (override)"
                zf.write(file, arc)

    if conflicts:
        warn("Namespace conflicts detected — main pack overrides:")
        for c in conflicts:
            warn(c)

    log(f"Merged ZIP: {merged_path.name}")

# ─── Submodule init ───────────────────────────────────────────────────────────

def cmd_init_submodules(deps: dict, root: Path):
    for dep_id, dep_cfg in deps.items():
        if isinstance(dep_cfg, str) or dep_cfg.get("source") != "submodule":
            continue
        url = dep_cfg.get("url")
        if not url:
            warn(f"[{dep_id}] Missing 'url' — cannot add submodule")
            continue
        path     = dep_cfg.get("path", str(SUBMODULE_DIR / dep_id))
        abs_path = root / path
        if abs_path.exists():
            log(f"[{dep_id}] Already present: {path}")
            continue
        log(f"[{dep_id}] git submodule add {url} {path}")
        result = subprocess.run(
            ["git", "submodule", "add", url, path],
            cwd=root, capture_output=True, text=True,
        )
        if result.returncode != 0:
            die(f"git submodule add failed:\n{result.stderr}")

# ─── CLI ──────────────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(
        description="Datapack dependency resolver",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Commands:
  resolve   Resolve dependencies and write lock file
  build     Resolve + produce ZIPs in dist/
  init      Add submodule deps via git submodule add
  check     Verify version constraints only (no output)

Examples:
  dp-resolve.py resolve --mode prod
  dp-resolve.py build --output both
  dp-resolve.py build --mode dev --output separate
        """,
    )
    parser.add_argument("command", choices=["resolve", "build", "init", "check"])
    parser.add_argument("--mode",   choices=["prod", "dev", "auto"], default="auto")
    parser.add_argument("--output", choices=["separate", "merged", "both"], default="separate")
    parser.add_argument("--root",   default=".", help="Project root directory")
    parser.add_argument("--token",  default=os.environ.get("GITHUB_TOKEN"))
    args = parser.parse_args()

    root     = Path(args.root).resolve()
    manifest = load_manifest(root)
    deps     = load_all_deps(root)

    log(f"Project: {manifest['id']} v{manifest['version']}")

    if args.command == "init":
        cmd_init_submodules(deps, root)
        return

    if args.command == "check":
        # No network — validate constraints against what's in the lock file
        lock          = load_lock(root)
        resolved_lock = lock.get("resolved", {})
        ok = True
        for dep_id, dep_cfg in deps.items():
            if isinstance(dep_cfg, str):
                dep_cfg = {"version": dep_cfg}
            constraint = dep_cfg.get("version", "*")
            lock_entry = resolved_lock.get(dep_id)
            if lock_entry:
                locked_ver = lock_entry.get("version", "unknown")
                try:
                    matches = version_matches(locked_ver, constraint)
                except ValueError as e:
                    warn(f"  {dep_id}: bad constraint '{constraint}': {e}")
                    ok = False
                    continue
                status = "OK" if matches else "FAIL"
                if not matches:
                    ok = False
                log(f"  {status}  {dep_id}: locked v{locked_ver} vs '{constraint}'")
            else:
                log(f"  ??   {dep_id}: not in lock file (run 'resolve' first)")
        if not deps:
            log("No dependencies declared.")
        elif ok:
            log("All constraints satisfied.")
        else:
            die("One or more constraint checks failed.")
        return

    resolved = resolve_all(deps, root, args.mode, args.token)

    if args.command in ("resolve", "build"):
        save_lock(root, {"resolved": resolved})
        log(f"Lock file updated: {LOCK_FILE}")

    if args.command == "build":
        log(f"Output mode: {args.output}")
        if args.output in ("separate", "both"):
            build_separate_zips(manifest, resolved, root, args.token)
        if args.output in ("merged", "both"):
            build_merged_zip(manifest, resolved, root, args.token)

    log("Done.")

if __name__ == "__main__":
    main()
