#!/bin/bash
# postStartCommand: her Codespace başlatılışında (rebuild olmasa bile) çalışır.
set -e

export SDKMAN_DIR="${SDKMAN_DIR:-$HOME/.sdkman}"
# shellcheck disable=SC1091
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

cd /workspace/suite

echo "☕ Java: $(java -version 2>&1 | head -1)"
echo "🐘 Gradle: $(/opt/gradle/bin/gradle -v 2>/dev/null | grep Gradle)"
echo "📂 Workspace: $(pwd)"
