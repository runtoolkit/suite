#!/bin/bash
set -e

# ── Package manager detection ─────────────────────────────────────────
for PM in apt-get apt yum dnf apk; do
  if command -v "$PM" &>/dev/null; then PKG="$PM"; break; fi
done
if [ -z "$PKG" ]; then
  echo "❌ No package manager found!" >&2
  exit 1
fi
echo "📦 Package manager: $PKG"

# ── sudo detection ────────────────────────────────────────────────────
SUDO=""
command -v sudo &>/dev/null && SUDO="sudo"

# ── PATH / env helpers ───────────────────────────────────────────────
append_path() {
  local DIR="$1"
  local MARKER="# path:$DIR"
  for RC in "$HOME/.bashrc" "$HOME/.profile"; do
    [ -f "$RC" ] || touch "$RC"
    grep -qF "$MARKER" "$RC" 2>/dev/null && continue
    printf '\n%s\nexport PATH="%s:$PATH"\n' "$MARKER" "$DIR" >> "$RC"
  done
  export PATH="$DIR:$PATH"
}

append_env() {
  local LINE="$1"
  local MARKER="$2"
  for RC in "$HOME/.bashrc" "$HOME/.profile"; do
    [ -f "$RC" ] || touch "$RC"
    grep -qF "$MARKER" "$RC" 2>/dev/null && continue
    printf '\n%s\n' "$LINE" >> "$RC"
  done
}

# ── System packages ───────────────────────────────────────────────────
echo "📦 Installing system packages..."
if [ "$PKG" = "apk" ]; then
  $SUDO apk update && $SUDO apk add --no-cache \
    git curl wget unzip zip build-base \
    python3 py3-pip ca-certificates gnupg coreutils bash \
    jq git-lfs python3-venv diffutils patch file shellcheck
else
  $SUDO $PKG update -y && $SUDO $PKG install -y \
    git curl wget unzip zip build-essential \
    python3 python3-pip python3-venv ca-certificates gnupg lsb-release \
    jq git-lfs diffutils patch file shellcheck
fi

# ── Git LFS init ──────────────────────────────────────────────────────
echo "🗂  Initializing Git LFS..."
git lfs install --system 2>/dev/null || git lfs install

# ── Node.js 20 ────────────────────────────────────────────────────────
echo "📦 Installing Node.js 20..."
if command -v node &>/dev/null; then
  echo "  Already installed: $(node -v)"
else
  wget -q -O /tmp/node.tar.gz \
    "https://nodejs.org/dist/v20.20.2/node-v20.20.2-linux-x64.tar.gz"
  $SUDO tar -xzf /tmp/node.tar.gz -C /usr/local --strip-components=1
  rm /tmp/node.tar.gz
fi

# ── SDKMAN ────────────────────────────────────────────────────────────
echo "🧰 Installing SDKMAN..."
export SDKMAN_DIR="${SDKMAN_DIR:-$HOME/.sdkman}"
if [ ! -f "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
  curl -s "https://get.sdkman.io" | bash
fi
# shellcheck disable=SC1091
source "$SDKMAN_DIR/bin/sdkman-init.sh"
append_env \
  '[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"' \
  'sdkman-init.sh'

# ── Java 25 (via SDKMAN, default candidate) ────────────────────────────
echo "☕ Installing Java 25 via SDKMAN..."
JAVA25_CANDIDATE="$(sdk list java 2>/dev/null | grep -oE '25(\.[0-9]+)*-tem' | head -1)"
if [ -z "$JAVA25_CANDIDATE" ]; then
  echo "❌ SDKMAN'da Java 25 (Temurin) sürümü bulunamadı!" >&2
  exit 1
fi
if ! sdk list java 2>/dev/null | grep -q "installed.*$JAVA25_CANDIDATE\|$JAVA25_CANDIDATE.*installed"; then
  sdk install java "$JAVA25_CANDIDATE" < /dev/null
fi
sdk default java "$JAVA25_CANDIDATE"
sdk use java "$JAVA25_CANDIDATE"
export JAVA_HOME="$SDKMAN_DIR/candidates/java/current"
append_env "export JAVA_HOME=\"\$HOME/.sdkman/candidates/java/current\"" "JAVA_HOME=SDKMAN"

# ── Gradle 9.4.0 (direct binary, matches gradle/wrapper/gradle-wrapper.properties) ──
echo "🐘 Installing Gradle 9.4.0..."
if [ ! -f "/opt/gradle/bin/gradle" ]; then
  wget -q -O /tmp/gradle.zip \
    "https://services.gradle.org/distributions/gradle-9.4.0-bin.zip"
  $SUDO mkdir -p /tmp/gradle-extract /opt/gradle
  $SUDO unzip -q /tmp/gradle.zip -d /tmp/gradle-extract
  $SUDO cp -r /tmp/gradle-extract/gradle-9.4.0/. /opt/gradle/
  $SUDO rm -rf /tmp/gradle-extract /tmp/gradle.zip
else
  echo "  Already installed: $(/opt/gradle/bin/gradle -v | grep Gradle)"
fi
append_path "/opt/gradle/bin"

# ── Workspace ────────────────────────────────────────────────────────
cd /workspaces/suite
chmod +x gradlew 2>/dev/null || true

mkdir -p .vscode && cat << 'EOF' > .vscode/settings.json
{
  "groovy.classpath": [
    "."
  ],
  "files.associations": {
    "*.gradle": "groovy"
  }
}
EOF

# ── Done ──────────────────────────────────────────────────────────────
echo ""
echo "✅ Versions:"
node -v
npm -v
java -version
/opt/gradle/bin/gradle -v | grep Gradle
jq --version
shellcheck --version | head -1
git lfs version
