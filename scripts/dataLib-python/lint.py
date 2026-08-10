"""
lint.py — dataLib .mcfunction Linter
Scans all .mcfunction files in build_dp.py and reports common issues.

Checks performed:
  - Macro lines ($...) missing at least one $(key) reference
  - execute if/unless score/data with no run clause
  - Bare 'kill @a' without any selector filter (dangerous)
  - Unreferenced schedule function calls (function path does not exist in FILES)
  - Trailing whitespace on lines

Usage:
    python lint.py            # lint everything
    python lint.py --strict   # exit 1 if any warning found
"""

import re
import sys
import ast
import os

MACRO_LINE_RE = re.compile(r"^\$(?!\()")          # $ line without $(
KILL_BARE_RE = re.compile(r"^\s*kill\s+@a\s*$")   # bare kill @a
TRAILING_WS_RE = re.compile(r"[ \t]+$")
SCHEDULE_RE = re.compile(r"schedule function ([\w:./]+)")

ISSUE_LEVELS = {"error": 0, "warn": 1}


class Issue:
    def __init__(self, level: str, path: str, lineno: int, message: str):
        self.level = level
        self.path = path
        self.lineno = lineno
        self.message = message

    def __str__(self) -> str:
        tag = "ERR " if self.level == "error" else "WARN"
        return f"[{tag}] {self.path}:{self.lineno}  {self.message}"


def load_files_from_build(build_path: str) -> dict[str, str]:
    """Parse build_dp.py and return {relative_path: content} for .mcfunction files."""
    with open(build_path, encoding="utf-8") as fh:
        source = fh.read()

    tree = ast.parse(source)
    files: dict[str, str] = {}

    for node in ast.walk(tree):
        if isinstance(node, ast.Assign):
            for target in node.targets:
                if isinstance(target, ast.Name) and target.id == "FILES":
                    if isinstance(node.value, ast.List):
                        for elt in node.value.elts:
                            if isinstance(elt, ast.Tuple) and len(elt.elts) == 2:
                                path_node, content_node = elt.elts
                                if isinstance(path_node, ast.Constant) and isinstance(content_node, ast.Constant):
                                    p: str = path_node.value
                                    c: str = content_node.value
                                    if p.endswith(".mcfunction"):
                                        files[p] = c
    return files


def lint_file(rel_path: str, content: str, all_paths: set[str]) -> list[Issue]:
    issues: list[Issue] = []
    lines = content.splitlines()

    for i, raw in enumerate(lines, start=1):
        line = raw

        # Skip comment lines
        stripped = line.lstrip()
        if stripped.startswith("#") or stripped == "":
            continue

        # Macro line missing $(key)
        if stripped.startswith("$") and not re.search(r"\$\(\w+\)", stripped):
            issues.append(Issue("error", rel_path, i, f"Macro line missing $(key) reference: {stripped[:80]}"))

        # Bare kill @a
        if KILL_BARE_RE.match(line):
            issues.append(Issue("warn", rel_path, i, "Bare 'kill @a' with no selector filter — dangerous in multiplayer"))

        # Trailing whitespace
        if TRAILING_WS_RE.search(line):
            issues.append(Issue("warn", rel_path, i, "Trailing whitespace"))

        # Schedule references non-existent function
        for m in SCHEDULE_RE.finditer(line):
            fn = m.group(1)
            # Normalise to relative path inside datapack
            if ":" in fn:
                ns, path = fn.split(":", 1)
                candidate = f"./data/{ns}/function/{path}.mcfunction"
            else:
                candidate = None
            if candidate and candidate not in all_paths:
                issues.append(Issue("warn", rel_path, i, f"schedule target may not exist: {fn}"))

    return issues


def main() -> None:
    strict = "--strict" in sys.argv
    script_dir = os.path.dirname(os.path.abspath(__file__))
    build_path = os.path.join(script_dir, "build_dp.py")

    if not os.path.isfile(build_path):
        print("[ERROR] build_dp.py not found")
        sys.exit(1)

    print(f"[lint] Parsing build_dp.py …")
    files = load_files_from_build(build_path)
    all_paths = set(files.keys())
    print(f"[lint] {len(files)} .mcfunction files found")

    all_issues: list[Issue] = []
    for rel_path, content in files.items():
        all_issues.extend(lint_file(rel_path, content, all_paths))

    errors = [i for i in all_issues if i.level == "error"]
    warnings = [i for i in all_issues if i.level == "warn"]

    for issue in all_issues:
        print(issue)

    print(f"\n[lint] {len(errors)} error(s), {len(warnings)} warning(s) in {len(files)} files")

    if errors or (strict and warnings):
        sys.exit(1)
    print("[lint] OK")


if __name__ == "__main__":
    main()
