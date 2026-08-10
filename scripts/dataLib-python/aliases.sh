#!/usr/bin/env bash
# dataLib-python — Shell Aliases
# ------------------------------------
# Source this file once to get short commands for the project tools.
#
# Usage (one-time in current shell):
#   source aliases.sh
#
# Usage (permanent — add to ~/.bashrc or ~/.zshrc):
#   echo "source /path/to/dataLib-python/aliases.sh" >> ~/.bashrc
#
# Available commands after sourcing:
#   dl-extract [output_dir]   → extract.py
#   dl-lint    [--strict]     → lint.py
#   dl-pack    <dir> [out]    → pack.py
#   dl-validate [build_path]  → validate.py
#   dl-init    [build_dir]    → build.py

echo "[DL] Aliases loading..."

_AME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

alias dl-extract="python3 \"$_AME_DIR/extract.py\""
alias dl-lint="python3 \"$_AME_DIR/lint.py\""
alias dl-pack="python3 \"$_AME_DIR/pack.py\""
alias dl-validate="python3 \"$_AME_DIR/validate.py\""
alias dl-init="python3 \"$_AME_DIR/build_dp.py\""

echo "[DL] Aliases loaded from: $_AME_DIR"
echo "  dl-extract   dl-lint   dl-pack   dl-validate   dl-init"
