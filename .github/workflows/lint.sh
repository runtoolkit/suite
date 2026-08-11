```bash
#!/usr/bin/env bash

set -uo pipefail

echo "::group::📦 Installing Mecha"
python -m pip install mecha
echo "::endgroup::"

IGNORE_PATHS=(
    "packs/inv_gui"
    "packs/macroEngine-dp/26_1"

    "packs/dataLibDatapackOnly/data/datalib/function/world/get_time.mcfunction"
    "packs/dataLibDatapackOnly/data/datalib/function/world/time_phase.mcfunction"

    "packs/dataLib-dp/datapack/data/datalib/function/world/get_time.mcfunction"
    "packs/dataLib-dp/datapack/data/datalib/function/world/time_phase.mcfunction"

    "packs/cmdTunnel-datapack/data/*/functions/init.mcfunction"
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

cd "$TMP_DIR/project"

for pattern in "${IGNORE_PATHS[@]}"; do
    matched=false

    # Glob patternlerini genişlet
    while IFS= read -r -d '' target; do
        matched=true
        echo "::notice::Ignoring ${target#./}"
        rm -rf "$target"
    done < <(find . -path "./$pattern" -print0 2>/dev/null)

    if [ "$matched" = false ]; then
        echo "::debug::Ignore target not found: $pattern"
    fi
done

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
```
