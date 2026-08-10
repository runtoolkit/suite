"""
extract.py — dataLib Datapack Extractor
Runs build_dp.py in a target directory to extract all datapack files.

Usage:
    python extract.py                  # extracts to dataLib-dp/
    python extract.py ./my_server/datapacks/macroEngine
"""

import os
import sys
import shutil
import subprocess

DEFAULT_OUTPUT = "./dataLib"


def main() -> None:
    output_dir = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_OUTPUT
    output_dir = os.path.abspath(output_dir)
    script_dir = os.path.dirname(os.path.abspath(__file__))
    build_script = os.path.join(script_dir, "build_dp.py")

    if not os.path.isfile(build_script):
        print("[ERROR] build_dp.py not found next to extract.py")
        sys.exit(1)

    if os.path.exists(output_dir):
        answer = input(f"[WARN] '{output_dir}' already exists. Overwrite? [y/N] ").strip().lower()
        if answer != "y":
            print("Aborted.")
            sys.exit(0)
        shutil.rmtree(output_dir)

    os.makedirs(output_dir, exist_ok=True)
    print(f"[extract] Extracting to: {output_dir}")

    result = subprocess.run(
        [sys.executable, build_script],
        cwd=output_dir,
        capture_output=True,
        text=True,
    )

    if result.returncode != 0:
        print(f"[ERROR] build_dp.py failed:\n{result.stderr}")
        sys.exit(result.returncode)

    print(f"[extract] {result.stdout.strip()}")
    print(f"[extract] Done → {output_dir}")


if __name__ == "__main__":
    main()
