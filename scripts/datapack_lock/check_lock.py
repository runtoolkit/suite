#!/usr/bin/env python3
"""
Fails (non-zero exit) if a pull request touches any file under a
packs/<name>/ directory that is marked "locked": true in
packs/.datapack-lock.json.

Usage:
    check_lock.py <path-to-lock-json> <changed-file-1> [<changed-file-2> ...]

Design notes (read before changing the logic):
- A top-level packs/ directory that has NO entry in the lock file at all
  is treated as new/unreviewed content and is allowed through here - that
  is the intentional path for adding a brand new pack. It is reported as
  a warning so a human notices and adds a locked entry for it in a
  prompt follow-up PR.
- A directory with an entry and "locked": true is protected: any changed
  path under it fails the check, full stop. Unlocking must happen as its
  own reviewed change to the lock file, merged *before* the edit, not in
  the same PR as the edit - otherwise "flip the flag and edit in one PR"
  would defeat the point of requiring separate review for the unlock.
- A directory with an entry and "locked": false is explicitly under
  maintenance and changes are allowed.
"""
import json
import sys
from collections import defaultdict


def top_level_pack_name(changed_path: str, packs_prefix: str = "packs/") -> str | None:
    if not changed_path.startswith(packs_prefix):
        return None
    rest = changed_path[len(packs_prefix):]
    if rest.startswith("."):
        # the lock file itself, or other dotfiles directly under packs/ - not a pack.
        return None
    parts = rest.split("/", 1)
    return parts[0] if parts else None


def main(argv: list[str]) -> int:
    if len(argv) < 2:
        print("usage: check_lock.py <lock-json-path> [changed-file ...]", file=sys.stderr)
        return 2

    lock_path = argv[0]
    changed_files = argv[1:]

    with open(lock_path, "r", encoding="utf-8") as handle:
        lock_data = json.load(handle)
    packs = lock_data.get("packs", {})

    touched_by_pack: dict[str, list[str]] = defaultdict(list)
    for changed_file in changed_files:
        pack_name = top_level_pack_name(changed_file)
        if pack_name is None:
            continue
        touched_by_pack[pack_name].append(changed_file)

    violations: list[tuple[str, list[str]]] = []
    new_packs: list[str] = []

    for pack_name, files in touched_by_pack.items():
        entry = packs.get(pack_name)
        if entry is None:
            new_packs.append(pack_name)
            continue
        if entry.get("locked", False):
            violations.append((pack_name, files))

    if new_packs:
        print("NOTE: new top-level pack director(y/ies) not yet in the lock file "
              f"(allowed through, but should be added and locked in a follow-up PR): {sorted(new_packs)}")

    if violations:
        print("\nFAILED: this PR modifies file(s) inside locked pack(s):\n", file=sys.stderr)
        for pack_name, files in violations:
            print(f"  packs/{pack_name}/ (locked: true)", file=sys.stderr)
            for f in files:
                print(f"    - {f}", file=sys.stderr)
        print(
            "\nTo edit a locked pack: open and merge a separate PR that sets its entry to "
            "'locked: false' in packs/.datapack-lock.json first, then make your change, "
            "then open a follow-up PR that sets it back to 'locked: true'.",
            file=sys.stderr,
        )
        return 1

    print("OK: no changes to locked pack content.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
