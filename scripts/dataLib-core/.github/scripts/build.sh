#!/usr/bin/env bash
set -Eeuo pipefail

echo "==> Preparing resources"

REPO_URL="https://github.com/runtoolkit/dataLib.git"
TMP_DIR="$(mktemp -d)"

cleanup() {
rm -rf "$TMP_DIR"
}
trap cleanup EXIT

git clone --depth 1 "$REPO_URL" "$TMP_DIR"

rm -rf "$TMP_DIR/.git"
rm -rf "$TMP_DIR/.github"

rm -f "$TMP_DIR/.gitignore"
rm -f "$TMP_DIR/.dependencies.json"
rm -f "$TMP_DIR/version.json"

mkdir -p src/main/resources

cp -a "$TMP_DIR"/. src/main/resources/

echo "==> Resource import complete"

echo "==> Environment"
java -version

echo "==> Cleaning Loom cache"
rm -rf .gradle/loom-cache

echo "==> Done"
echo "Workflow may now execute:"
echo "./gradlew clean build --stacktrace"
