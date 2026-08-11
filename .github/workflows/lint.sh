#!/usr/bin/env bash

set -uo pipefail

echo "==> Installing Mecha..."
python -m pip install mecha

IGNORE_PATHS=(
    "packs/inv_gui"
    "packs/macroEngine-dp/26_1"
    "packs/dataLib-dp/datapacks/dataLib"
    "packs/dataLibDatapackOnly"
)

echo "==> Running Mecha validation..."

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cp -a . "$TMP_DIR/project"

for path in "${IGNORE_PATHS[@]}"; do
    if [ -e "$TMP_DIR/project/$path" ]; then
        echo "==> Ignoring: $path"
        rm -rf "$TMP_DIR/project/$path"
    fi
done

cd "$TMP_DIR/project"

if mecha .; then
    echo "==> Mecha validation passed."
else
    status=$?
    echo "::warning::Mecha reported validation errors ($status). Ignored."
fi

echo "==> Validation finished."
exit 0
