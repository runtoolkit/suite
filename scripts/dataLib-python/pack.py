"""
pack.py — dataLib Datapack Packer
Reads an extracted datapack directory and regenerates build_dp.py.

The inverse of extract.py: given a folder with all the datapack files,
it walks the tree and writes a new build_dp.py with every file embedded.

Usage:
    python pack.py dataLib-dp          # output → ./build_dp.py
    python pack.py dataLib-dp ./out/   # output → ./out/build_dp.py

Notes:
  - Binary files are skipped (only UTF-8 text files are embedded).
  - .git, __pycache__, *.py, *.pyc are excluded.
  - Output is always UTF-8, LF line endings.
"""

import os
import sys

SKIP_EXTENSIONS = {".py", ".pyc", ".pyo", ".git"}
SKIP_DIRS = {".git", "__pycache__", ".github"}

HEADER = '''\
import os

# Auto-generated — {count} files

FILES = [
'''

FOOTER = ''']

for path, content in FILES:
    d = os.path.dirname(path)
    if d:
        os.makedirs(d, exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
print(f"OK — {{len(FILES)}} files extracted.")
'''


def collect_files(root: str) -> list[tuple[str, str]]:
    """Walk root and return list of (relative_path, content) tuples."""
    results: list[tuple[str, str]] = []

    for dirpath, dirnames, filenames in os.walk(root):
        # Prune skipped directories in-place
        dirnames[:] = [d for d in dirnames if d not in SKIP_DIRS]
        dirnames.sort()

        for fname in sorted(filenames):
            _, ext = os.path.splitext(fname)
            if ext in SKIP_EXTENSIONS:
                continue

            abs_path = os.path.join(dirpath, fname)
            rel_path = "./" + os.path.relpath(abs_path, root).replace(os.sep, "/")

            try:
                with open(abs_path, encoding="utf-8") as fh:
                    content = fh.read()
            except (UnicodeDecodeError, PermissionError):
                print(f"[pack] SKIP (binary/unreadable): {rel_path}")
                continue

            results.append((rel_path, content))

    return results


def escape_content(content: str) -> str:
    """Escape content for embedding as a Python string literal."""
    return content.replace("\\", "\\\\").replace("'", "\\'").replace("\n", "\\n")


def write_build(files: list[tuple[str, str]], output_path: str) -> None:
    with open(output_path, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(HEADER.format(count=len(files)))
        for i, (rel_path, content) in enumerate(files):
            escaped = escape_content(content)
            comma = "," if i < len(files) - 1 else ""
            fh.write(f"    ({rel_path!r}, '{escaped}'){comma}\n")
        fh.write(FOOTER)


def main() -> None:
    if len(sys.argv) < 2:
        print("Usage: python pack.py <datapack_dir> [output_dir]")
        sys.exit(1)

    datapack_dir = os.path.abspath(sys.argv[1])
    if not os.path.isdir(datapack_dir):
        print(f"[ERROR] Not a directory: {datapack_dir}")
        sys.exit(1)

    output_dir = os.path.abspath(sys.argv[2]) if len(sys.argv) > 2 else os.getcwd()
    os.makedirs(output_dir, exist_ok=True)
    output_path = os.path.join(output_dir, "build_dp.py")

    print(f"[pack] Scanning: {datapack_dir}")
    files = collect_files(datapack_dir)
    print(f"[pack] {len(files)} files collected")

    write_build(files, output_path)
    size_kb = os.path.getsize(output_path) / 1024
    print(f"[pack] Written → {output_path} ({size_kb:.1f} KB)")


if __name__ == "__main__":
    main()
