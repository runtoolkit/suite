#!/usr/bin/env python3
"""
depend_edit.py — Dependency editor for dp-depman.

Commands:
  add     Add a new dependency to .depends/
  update  Update a field in an existing dependency
  set     Replace an entire dependency declaration
  show    Print a dependency's current config
  list    List all dependencies
  init    Create .depends/manifest.json interactively
"""

import argparse
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from _dp_common import (
    DEPENDS_DIR, MANIFEST_FILE,
    load_manifest, load_dep, load_all_deps, save_dep, save_manifest,
    _write_json,
    log, warn, die,
)

# ─── Validation ───────────────────────────────────────────────────────────────

VALID_SOURCES = {"github", "submodule"}

CONSTRAINT_RE = r"^(\d+\.\d+(\.\d+)*(\.x)?|[><=~^]+\d+\.\d+(\.\d+)*)$"

def validate_dep(dep_id: str, dep_cfg: dict):
    import re
    errors = []

    source = dep_cfg.get("source")
    if source not in VALID_SOURCES:
        errors.append(f"'source' must be one of {sorted(VALID_SOURCES)}, got: {source!r}")

    version = dep_cfg.get("version")
    if not version:
        errors.append("'version' is required")
    elif not re.match(CONSTRAINT_RE, version):
        errors.append(f"'version' constraint looks malformed: {version!r}")

    if source == "github":
        if not dep_cfg.get("repo"):
            errors.append("'repo' is required for source=github (e.g. 'runtoolkit/dataLib')")
        elif "/" not in dep_cfg["repo"]:
            errors.append(f"'repo' must be 'owner/name', got: {dep_cfg['repo']!r}")

    if source == "submodule":
        if not dep_cfg.get("url"):
            errors.append("'url' is required for source=submodule")

    if errors:
        print(f"[depend_edit] Validation failed for '{dep_id}':")
        for e in errors:
            print(f"  ✗ {e}")
        sys.exit(1)

# ─── Commands ─────────────────────────────────────────────────────────────────

def cmd_add(root: Path, dep_id: str, dep_cfg: dict, force: bool):
    existing = load_dep(root, dep_id)
    if existing and not force:
        die(
            f"Dependency '{dep_id}' already exists.\n"
            f"  Use --force to overwrite, or 'update' to change individual fields."
        )

    validate_dep(dep_id, dep_cfg)
    save_dep(root, dep_id, dep_cfg)

    action = "Updated" if existing else "Added"
    log(f"{action}: .depends/{dep_id}.json")
    _print_dep(dep_id, dep_cfg)


def cmd_update(root: Path, dep_id: str, fields: dict[str, str]):
    dep_cfg = load_dep(root, dep_id)
    if dep_cfg is None:
        die(f"Dependency '{dep_id}' not found. Use 'add' to create it.")

    # Apply field updates
    for key, value in fields.items():
        if value == "":
            # Empty string → remove the field
            dep_cfg.pop(key, None)
            log(f"  Removed field: {key}")
        else:
            dep_cfg[key] = value
            log(f"  Set {key} = {value!r}")

    validate_dep(dep_id, dep_cfg)
    save_dep(root, dep_id, dep_cfg)
    log(f"Updated: .depends/{dep_id}.json")
    _print_dep(dep_id, dep_cfg)


def cmd_set(root: Path, dep_id: str, raw_json: str):
    """Replace entire dep config from a JSON string."""
    try:
        dep_cfg = json.loads(raw_json)
    except json.JSONDecodeError as e:
        die(f"Invalid JSON: {e}")

    validate_dep(dep_id, dep_cfg)
    existing = load_dep(root, dep_id)
    save_dep(root, dep_id, dep_cfg)

    action = "Replaced" if existing else "Created"
    log(f"{action}: .depends/{dep_id}.json")
    _print_dep(dep_id, dep_cfg)


def cmd_show(root: Path, dep_id: str):
    dep_cfg = load_dep(root, dep_id)
    if dep_cfg is None:
        die(f"Dependency '{dep_id}' not found.")
    _print_dep(dep_id, dep_cfg)


def cmd_list(root: Path):
    manifest = load_manifest(root)
    deps     = load_all_deps(root)

    print(f"\n{manifest['id']} v{manifest['version']}")
    print(f"{'─' * 50}")

    if not deps:
        print("  No dependencies declared.")
        print(f"  Add one: depend_edit.py add <id> --source github --repo owner/repo --version '>=1.0.0'")
        print()
        return

    for dep_id, dep_cfg in sorted(deps.items()):
        source     = dep_cfg.get("source", "?")
        constraint = dep_cfg.get("version", "?")
        detail     = dep_cfg.get("repo") or dep_cfg.get("path") or dep_cfg.get("url", "")
        print(f"  {dep_id:<20} {source:<10} {constraint:<12}  {detail}")

    print()


def cmd_init(root: Path, pack_id: str | None, version: str | None, description: str | None):
    """Create .depends/manifest.json. Interactive if fields not provided."""
    dep_dir = root / DEPENDS_DIR
    manifest_path = dep_dir / MANIFEST_FILE

    if manifest_path.exists():
        current = load_manifest(root)
        warn(f"manifest.json already exists (id={current['id']!r}, version={current['version']!r})")
        try:
            answer = input("Overwrite? [y/N] ").strip().lower()
        except (EOFError, KeyboardInterrupt):
            print()
            log("Aborted.")
            return
        if answer not in ("y", "yes"):
            log("Aborted.")
            return

    if not pack_id:
        try:
            pack_id = input("Pack ID (e.g. examplePack): ").strip()
        except (EOFError, KeyboardInterrupt):
            print(); die("Aborted.")
    if not version:
        try:
            version = input("Version (e.g. 1.0.0) [1.0.0]: ").strip() or "1.0.0"
        except (EOFError, KeyboardInterrupt):
            print(); die("Aborted.")
    if description is None:
        try:
            description = input("Description (optional): ").strip()
        except (EOFError, KeyboardInterrupt):
            print(); description = ""

    manifest = {"id": pack_id, "version": version}
    if description:
        manifest["description"] = description

    save_manifest(root, manifest)
    log(f"Created: .depends/manifest.json  (id={pack_id!r}, version={version!r})")


# ─── Display helper ───────────────────────────────────────────────────────────

def _print_dep(dep_id: str, dep_cfg: dict):
    print(f"\n  .depends/{dep_id}.json")
    for k, v in dep_cfg.items():
        print(f"    {k:<10} {v!r}")
    print()

# ─── CLI ──────────────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(
        description="Dependency editor for dp-depman",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Add a GitHub dependency
  depend_edit.py add dataLib --source github --repo runtoolkit/dataLib --version '>=6.0.0' --asset dataLib-full.zip

  # Add a submodule dependency
  depend_edit.py add cbplus --source submodule --url https://github.com/runtoolkit/CBPlus.git --version '>=1.0.0'

  # Update the version constraint
  depend_edit.py update dataLib --version '>=6.1.0'

  # Update the asset name
  depend_edit.py update dataLib --asset dataLib-full.zip

  # Replace entire dep from JSON
  depend_edit.py set dataLib '{"source":"github","repo":"runtoolkit/dataLib","version":">=6.0.0","asset":"dataLib-full.zip"}'

  # Show a dependency
  depend_edit.py show dataLib

  # List all
  depend_edit.py list

  # Create manifest
  depend_edit.py init --id myPack --version 1.0.0
        """,
    )

    sub = parser.add_subparsers(dest="command", required=True)

    # ── add ──
    p_add = sub.add_parser("add", help="Add a new dependency")
    p_add.add_argument("dep_id")
    p_add.add_argument("--source",  required=True, choices=list(VALID_SOURCES))
    p_add.add_argument("--version", required=True)
    p_add.add_argument("--repo",    help="GitHub: owner/repo")
    p_add.add_argument("--asset",   help="GitHub: release asset filename")
    p_add.add_argument("--url",     help="Submodule: git URL")
    p_add.add_argument("--path",    help="Submodule: local path (default: deps/<id>)")
    p_add.add_argument("--force",   action="store_true", help="Overwrite if exists")
    p_add.add_argument("--root",    default=".")

    # ── update ──
    p_upd = sub.add_parser("update", help="Update fields of an existing dependency")
    p_upd.add_argument("dep_id")
    p_upd.add_argument("--version")
    p_upd.add_argument("--repo")
    p_upd.add_argument("--asset")
    p_upd.add_argument("--url")
    p_upd.add_argument("--path")
    p_upd.add_argument("--source", choices=list(VALID_SOURCES))
    p_upd.add_argument("--root",   default=".")

    # ── set ──
    p_set = sub.add_parser("set", help="Replace entire dep config from JSON string")
    p_set.add_argument("dep_id")
    p_set.add_argument("json", metavar="JSON")
    p_set.add_argument("--root", default=".")

    # ── show ──
    p_show = sub.add_parser("show", help="Print a dependency's config")
    p_show.add_argument("dep_id")
    p_show.add_argument("--root", default=".")

    # ── list ──
    p_list = sub.add_parser("list", help="List all dependencies")
    p_list.add_argument("--root", default=".")

    # ── init ──
    p_init = sub.add_parser("init", help="Create .depends/manifest.json")
    p_init.add_argument("--id",          dest="pack_id")
    p_init.add_argument("--version")
    p_init.add_argument("--description", default=None)
    p_init.add_argument("--root",        default=".")

    args = parser.parse_args()
    root = Path(args.root).resolve()

    if args.command == "add":
        dep_cfg: dict = {"source": args.source, "version": args.version}
        if args.repo:    dep_cfg["repo"]  = args.repo
        if args.asset:   dep_cfg["asset"] = args.asset
        if args.url:     dep_cfg["url"]   = args.url
        if args.path:    dep_cfg["path"]  = args.path
        cmd_add(root, args.dep_id, dep_cfg, args.force)

    elif args.command == "update":
        fields = {}
        for key in ("version", "repo", "asset", "url", "path", "source"):
            val = getattr(args, key, None)
            if val is not None:
                fields[key] = val
        if not fields:
            die("No fields specified. Pass at least one of: --version --repo --asset --url --path --source")
        cmd_update(root, args.dep_id, fields)

    elif args.command == "set":
        cmd_set(root, args.dep_id, args.json)

    elif args.command == "show":
        cmd_show(root, args.dep_id)

    elif args.command == "list":
        cmd_list(root)

    elif args.command == "init":
        cmd_init(root, args.pack_id, args.version, args.description)


if __name__ == "__main__":
    main()
