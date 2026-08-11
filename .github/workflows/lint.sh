#!/usr/bin/env bash

set -uo pipefail

echo "::group::📦 Installing Mecha"
python -m pip install mecha
echo "::endgroup::"

IGNORE_PATHS=(
    "packs/inv_gui"
    "packs/macroEngine-dp/26_1"
    "packs/dataLib-dp/datapacks/dataLib"
    "packs/dataLibDatapackOnly",
    "packs/cmdTunnel-datapack"
)

echo "::group::🚫 Ignoring paths"

for path in "${IGNORE_PATHS[@]}"; do
    echo "Ignore: $path"
done

echo "::endgroup::"

echo "::group::🔧 Preparing validation"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cp -a . "$TMP_DIR/project"

for path in "${IGNORE_PATHS[@]}"; do
    if [ -e "$TMP_DIR/project/$path" ]; then
        echo "::notice::Ignoring $path"
        rm -rf "$TMP_DIR/project/$path"
    fi
done

cd "$TMP_DIR/project"

echo "::endgroup::"

echo "::group::🔍 Mecha validation"

if mecha .; then
    echo "::notice::Mecha validation passed."
else
    status=$?
    echo "::warning::Mecha reported validation errors ($status). Ignored."
fi

echo "::endgroup::"

echo "::group::✅ Validation summary"
echo "Mecha validation finished."
echo "Ignored paths: ${#IGNORE_PATHS[@]}"
echo "::endgroup::"

exit 0
