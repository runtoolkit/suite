#!/usr/bin/env python3
"""
depend_remover.py — Safe dependency removal for dp-depman.

Safety checks before removing a .depends/<dep_id>.json file:
  1. Dependency must exist.
  2. Check lock file — warn if it was resolved (remove stale lock entry too).
  3. Check .dp-cache — offer to clean cached ZIPs for this dep.
  4. Require explicit confirmation unless --yes is passed.
  5. Never delete without printing exactly what will be removed.
"""

import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from _dp_common import (
    CACHE_DIR, DEPENDS_DIR, LOCK_FILE,
    load_manifest, load_dep, load_all_deps, load_lock, save_lock,
    delete_dep, _write_json,
    log, warn, die,
)

# ─── Safety checks ────────────────────────────────────────────────────────────

def find_cache_files(root: Path, dep_id: str) -> list[Path]:
    """Find all cached ZIPs for this dependency."""
    cache = root / CACHE_DIR
    if not cache.exists():
        return []
    return [f for f in cache.iterdir() if f.name.startswith(f"{dep_id}-") and f.suffix == ".zip"]

def check_lock(root: Path, dep_id: str) -> dict | None:
    """Return lock entry for dep_id if it exists."""
    lock = load_lock(root)
    return lock.get("resolved", {}).get(dep_id)

def remove_from_lock(root: Path, dep_id: str):
    lock = load_lock(root)
    resolved = lock.get("resolved", {})
    if dep_id in resolved:
        del resolved[dep_id]
        lock["resolved"] = resolved
        save_lock(root, lock)
        log(f"  Removed '{dep_id}' from lock file.")

# ─── Confirmation ─────────────────────────────────────────────────────────────

def confirm(prompt: str, yes: bool) -> bool:
    if yes:
        return True
    try:
        answer = input(f"{prompt} [y/N] ").strip().lower()
    except (EOFError, KeyboardInterrupt):
        print()
        return False
    return answer in ("y", "yes")

# ─── Remove command ───────────────────────────────────────────────────────────

def cmd_remove(root: Path, dep_id: str, yes: bool, clean_cache: bool):
    dep_file = root / DEPENDS_DIR / f"{dep_id}.json"

    # 1. Existence check
    if not dep_file.exists():
        # Try listing what IS available
        all_deps = load_all_deps(root)
        if all_deps:
            log(f"Declared dependencies: {', '.join(sorted(all_deps))}")
        die(f"Dependency '{dep_id}' not found in .depends/")

    dep_cfg    = load_dep(root, dep_id)
    lock_entry = check_lock(root, dep_id)
    cache_files = find_cache_files(root, dep_id)

    # 2. Print removal plan
    print()
    print(f"  Will remove: .depends/{dep_id}.json")
    print(f"    source:    {dep_cfg.get('source', '?')}")
    if dep_cfg.get("repo"):
        print(f"    repo:      {dep_cfg['repo']}")
    if dep_cfg.get("path"):
        print(f"    path:      {dep_cfg['path']}")
    print(f"    version:   {dep_cfg.get('version', '?')}")

    if lock_entry:
        print(f"  Will remove from lock: {dep_id} (resolved v{lock_entry.get('version', '?')})")

    if cache_files:
        if clean_cache:
            for cf in cache_files:
                print(f"  Will delete cache: {cf.name}")
        else:
            print(f"  Cache files found ({len(cache_files)}) — pass --clean-cache to delete them:")
            for cf in cache_files:
                print(f"    {cf.name}")

    # 3. Submodule warning
    if dep_cfg.get("source") == "submodule":
        path = dep_cfg.get("path", f"deps/{dep_id}")
        print()
        warn(f"This dependency uses a git submodule at '{path}'.")
        warn(f"This tool only removes the .depends/{dep_id}.json declaration.")
        warn(f"To fully remove the submodule run:")
        warn(f"  git submodule deinit -f {path}")
        warn(f"  git rm -f {path}")
        warn(f"  rm -rf .git/modules/{path}")

    print()

    # 4. Confirm
    if not confirm(f"Remove dependency '{dep_id}'?", yes):
        log("Aborted.")
        sys.exit(0)

    # 5. Execute
    deleted = delete_dep(root, dep_id)
    if deleted:
        log(f"Removed: .depends/{dep_id}.json")
    else:
        die(f"Failed to delete .depends/{dep_id}.json")

    if lock_entry:
        remove_from_lock(root, dep_id)

    if clean_cache and cache_files:
        for cf in cache_files:
            cf.unlink()
            log(f"Deleted cache: {cf.name}")

    log(f"Done. Run 'dp-resolve.py resolve' to update the lock file.")


def cmd_list(root: Path):
    """List all declared dependencies and their lock status."""
    manifest = load_manifest(root)
    deps     = load_all_deps(root)
    lock     = load_lock(root)
    resolved = lock.get("resolved", {})

    print(f"\n{manifest['id']} v{manifest['version']}")
    print(f"{'─' * 50}")

    if not deps:
        print("  No dependencies declared.")
        return

    for dep_id, dep_cfg in sorted(deps.items()):
        source     = dep_cfg.get("source", "?")
        constraint = dep_cfg.get("version", "?")
        lock_ver   = resolved.get(dep_id, {}).get("version")
        lock_str   = f"  [locked: v{lock_ver}]" if lock_ver else "  [not locked]"
        print(f"  {dep_id:<20} {source:<10} {constraint:<12}{lock_str}")

    print()

# ─── CLI ──────────────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(
        description="Safe dependency removal for dp-depman",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Commands:
  remove <dep_id>   Remove a dependency declaration
  list              List all declared dependencies

Examples:
  depend_remover.py remove dataLib
  depend_remover.py remove dataLib --yes
  depend_remover.py remove dataLib --yes --clean-cache
  depend_remover.py list
        """,
    )
    parser.add_argument("command", choices=["remove", "list"])
    parser.add_argument("dep_id",  nargs="?", help="Dependency ID to remove")
    parser.add_argument("--root",  default=".", help="Project root directory")
    parser.add_argument("--yes",   action="store_true", help="Skip confirmation prompt")
    parser.add_argument(
        "--clean-cache", action="store_true",
        help="Also delete cached ZIPs for this dependency",
    )
    args = parser.parse_args()

    root = Path(args.root).resolve()

    if args.command == "list":
        cmd_list(root)
        return

    if args.command == "remove":
        if not args.dep_id:
            parser.error("remove requires a dep_id argument")
        cmd_remove(root, args.dep_id, args.yes, args.clean_cache)

if __name__ == "__main__":
    main()
