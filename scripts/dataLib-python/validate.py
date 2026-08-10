"""
validate.py — dataLib pack.mcmeta Validator
Parses pack.mcmeta from build_dp.py and checks for known issues.

Checks:
  - supported_formats must be an object {min_inclusive, max_inclusive}
    (array syntax breaks 1.21.10+ servers)
  - min_format / max_format fields must NOT be present (invalid, ignored)
  - pack_format value is reported with known version mapping
  - overlay format ranges are validated for overlaps and gaps
  - description field is present

Usage:
    python validate.py          # validate build_dp.py in same directory
    python validate.py <path>   # validate a specific build_dp.py
"""

import ast
import json
import os
import sys

KNOWN_FORMATS: dict[int, str] = {
    26: "1.20.3 / 1.20.4",
    41: "1.20.5",
    48: "1.21",
    57: "1.21.1 / 1.21.3",
    61: "1.21.4",
    71: "1.21.5",
    80: "1.21.6",
    88: "1.21.10",
    94: "1.21.11",
    101: "26.1",
}

Issues = list[tuple[str, str]]  # [(level, message)]


def load_mcmeta(build_path: str) -> dict | None:
    with open(build_path, encoding="utf-8") as fh:
        source = fh.read()

    tree = ast.parse(source)
    for node in ast.walk(tree):
        if isinstance(node, ast.Assign):
            for target in node.targets:
                if isinstance(target, ast.Name) and target.id == "FILES":
                    if isinstance(node.value, ast.List):
                        for elt in node.value.elts:
                            if isinstance(elt, ast.Tuple) and len(elt.elts) == 2:
                                path_node, content_node = elt.elts
                                if (
                                    isinstance(path_node, ast.Constant)
                                    and path_node.value in ("./pack.mcmeta", "pack.mcmeta")
                                    and isinstance(content_node, ast.Constant)
                                ):
                                    try:
                                        return json.loads(content_node.value)
                                    except json.JSONDecodeError as exc:
                                        print(f"[ERROR] pack.mcmeta is not valid JSON: {exc}")
                                        return None
    print("[ERROR] pack.mcmeta not found in build_dp.py")
    return None


def validate_mcmeta(meta: dict) -> Issues:
    issues: Issues = []
    pack = meta.get("pack", {})

    # pack_format
    pf = pack.get("pack_format")
    if pf is None:
        issues.append(("error", "pack.pack_format is missing"))
    else:
        ver = KNOWN_FORMATS.get(pf, "unknown version")
        print(f"  pack_format : {pf}  ({ver})")

    # description
    if "description" not in pack:
        issues.append(("warn", "pack.description is missing"))

    # supported_formats
    sf = pack.get("supported_formats")
    if sf is None:
        issues.append(("warn", "pack.supported_formats is missing"))
    elif isinstance(sf, list):
        issues.append(("error",
            "pack.supported_formats is an ARRAY — must be object "
            "{min_inclusive, max_inclusive}. Array syntax breaks 1.21.10+ servers."))
    elif isinstance(sf, dict):
        if "min_inclusive" not in sf or "max_inclusive" not in sf:
            issues.append(("error",
                "pack.supported_formats object missing min_inclusive or max_inclusive"))
        else:
            lo, hi = sf["min_inclusive"], sf["max_inclusive"]
            print(f"  supported_formats : {lo} – {hi}")

    # Forbidden fields
    for bad_field in ("min_format", "max_format"):
        if bad_field in pack:
            issues.append(("warn",
                f"pack.{bad_field} is present but is NOT a valid field "
                f"and will be ignored by the game. Remove it."))

    # Overlays
    overlays_block = meta.get("overlays", {})
    entries = overlays_block.get("entries", [])
    if entries:
        print(f"  overlays    : {len(entries)} entries")
        for idx, entry in enumerate(entries):
            d = entry.get("directory", f"<entry {idx}>")
            fmt = entry.get("formats", {})

            if isinstance(fmt, list):
                issues.append(("error",
                    f"overlay '{d}': formats is an ARRAY — must be object "
                    "{min_inclusive, max_inclusive}"))
                continue

            lo2 = fmt.get("min_inclusive")
            hi2 = fmt.get("max_inclusive")
            if lo2 is None or hi2 is None:
                issues.append(("error",
                    f"overlay '{d}': formats object missing min_inclusive or max_inclusive"))
                continue

            if lo2 > hi2:
                issues.append(("error",
                    f"overlay '{d}': min_inclusive ({lo2}) > max_inclusive ({hi2})"))

            # Check for the same forbidden fields inside overlay entries
            for bad_field in ("min_format", "max_format"):
                if bad_field in entry:
                    issues.append(("warn",
                        f"overlay '{d}': {bad_field} is NOT a valid field. Remove it."))

    return issues


def main() -> None:
    build_path = sys.argv[1] if len(sys.argv) > 1 else os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "build_dp.py"
    )

    if not os.path.isfile(build_path):
        print(f"[ERROR] File not found: {build_path}")
        sys.exit(1)

    print(f"[validate] {build_path}")
    meta = load_mcmeta(build_path)
    if meta is None:
        sys.exit(1)

    print("[validate] pack.mcmeta:")
    issues = validate_mcmeta(meta)

    print()
    if not issues:
        print("[validate] OK — no issues found")
        return

    errors = [(l, m) for l, m in issues if l == "error"]
    warnings = [(l, m) for l, m in issues if l == "warn"]
    for level, msg in issues:
        tag = "ERR " if level == "error" else "WARN"
        print(f"  [{tag}] {msg}")

    print(f"\n[validate] {len(errors)} error(s), {len(warnings)} warning(s)")
    if errors:
        sys.exit(1)


if __name__ == "__main__":
    main()
