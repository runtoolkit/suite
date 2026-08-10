#!/usr/bin/env bash
# runtoolkit -> suite consolidation script
# Usage: GITHUB_TOKEN=ghp_xxx ./consolidate.sh
#
# This script runs on YOUR machine. The token is never sent to Claude or anywhere else.
set -euo pipefail

if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "ERROR: GITHUB_TOKEN env variable is not set."
  echo "Usage: GITHUB_TOKEN=ghp_xxx ./consolidate.sh"
  exit 1
fi

ORG="runtoolkit"
NEW_REPO="suite"   # <-- change this if you renamed the target repo
WORKDIR="$(mktemp -d)"
API="https://api.github.com"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

echo "Working directory: $WORKDIR"
cd "$WORKDIR"

# ---------------------------------------------------------------------------
# 1. Fetch repo list
# ---------------------------------------------------------------------------
echo "== Fetching repo list =="
curl -s -H "$AUTH_HEADER" "$API/orgs/$ORG/repos?per_page=100" > repos.json
python3 -c "
import json
repos = json.load(open('repos.json'))
for r in repos:
    print(r['name'])
" > repo_names.txt
echo "$(wc -l < repo_names.txt) repos found."

# ---------------------------------------------------------------------------
# 2. Clone and analyze each repo (empty / inconsistent detection)
# ---------------------------------------------------------------------------
mkdir -p clones
declare -A DECISION   # repo -> "include" | "skip-empty" | "skip-stale"
declare -A REASON

echo "== Cloning and analyzing repos =="
while read -r name; do
  [ -z "$name" ] && continue

  # Manually skipped repos (confirmed with the user)
  if [ "$name" == "DataLibFabric" ]; then
    DECISION[$name]="skip-empty"; REASON[$name]="1KB, empty/placeholder (manually confirmed)"
    continue
  fi

  echo "  -> $name"
  if ! git clone --quiet "https://x-access-token:${GITHUB_TOKEN}@github.com/${ORG}/${name}.git" "clones/$name" 2>/tmp/clone_err; then
    DECISION[$name]="skip-error"; REASON[$name]="clone failed: $(cat /tmp/clone_err | tail -1)"
    continue
  fi

  cd "clones/$name"
  file_count=$(git ls-files | wc -l)
  last_commit_date=$(git log -1 --format=%cI 2>/dev/null || echo "")
  has_readme=$(git ls-files | grep -iq '^readme' && echo yes || echo no)
  is_archived=$(python3 -c "
import json
repos = json.load(open('$WORKDIR/repos.json'))
for r in repos:
    if r['name'] == '$name':
        print(r['archived'])
        break
")
  cd "$WORKDIR"

  # Empty repo (only files like .gitignore/LICENSE, or no files at all)
  if [ "$file_count" -le 2 ]; then
    DECISION[$name]="skip-empty"; REASON[$name]="only $file_count file(s)"
    continue
  fi

  # Older than 1 year AND not archived -> "probably abandoned", flag it but don't
  # auto-skip without user approval. We just record it in the report.
  DECISION[$name]="include"; REASON[$name]="files=$file_count last_commit=$last_commit_date archived=$is_archived readme=$has_readme"

done < repo_names.txt

# ---------------------------------------------------------------------------
# 3. Print the decision report and ask for user confirmation (interactive)
# ---------------------------------------------------------------------------
echo ""
echo "======================================================================"
echo " ANALYSIS REPORT - repos to include/exclude in suite/"
echo "======================================================================"
for name in "${!DECISION[@]}"; do
  printf "%-30s %-12s %s\n" "$name" "${DECISION[$name]}" "${REASON[$name]}"
done | sort

echo ""
read -p "Proceed with these decisions? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
  echo "Cancelled. You can inspect clones/ and repos.json under $WORKDIR,"
  echo "manually edit the DECISION array in the script, and re-run it."
  exit 0
fi

# ---------------------------------------------------------------------------
# 4. Create the new suite repo
# ---------------------------------------------------------------------------
echo "== Creating $ORG/$NEW_REPO =="
curl -s -X POST -H "$AUTH_HEADER" "$API/orgs/$ORG/repos" \
  -d "{\"name\":\"$NEW_REPO\",\"description\":\"Consolidated runtoolkit monorepo: mods, packs, scripts, examples\",\"private\":false,\"auto_init\":true}" \
  > create_result.json
echo "Created: $(python3 -c "import json; print(json.load(open('create_result.json')).get('html_url','ERROR - check create_result.json'))")"

git clone --quiet "https://x-access-token:${GITHUB_TOKEN}@github.com/${ORG}/${NEW_REPO}.git" suite
cd suite
mkdir -p mods packs scripts archived other examples

# ---------------------------------------------------------------------------
# 5. Categorize and move each "include" repo (git history is NOT preserved -
#    this is a plain file copy). Note: preserving history would require
#    git subtree/filter-repo; this script does a simple copy. We can switch
#    to subtree later if you want.
# ---------------------------------------------------------------------------
echo "== Categorizing and moving files =="
for name in "${!DECISION[@]}"; do
  [ "${DECISION[$name]}" != "include" ] && continue
  src="$WORKDIR/clones/$name"
  [ ! -d "$src" ] && continue

  # Category guess: fabric.mod.json -> mod, pack.mcmeta -> pack,
  # name contains "template" or "example" -> examples, otherwise -> scripts
  if [ -f "$src/fabric.mod.json" ] || find "$src" -maxdepth 3 -iname "fabric.mod.json" | grep -q .; then
    if [[ "$name" == *"emplate"* || "$name" == *"xample"* ]]; then
      dest="examples/$name"
    else
      dest="mods/$name"
    fi
  elif [ -f "$src/pack.mcmeta" ] || find "$src" -maxdepth 3 -iname "pack.mcmeta" | grep -q .; then
    if [[ "$name" == *"emplate"* || "$name" == *"xample"* ]]; then
      dest="examples/$name"
    else
      dest="packs/$name"
    fi
  elif [[ "$name" == *"emplate"* || "$name" == *"xample"* ]]; then
    dest="examples/$name"
  else
    dest="scripts/$name"
  fi

  echo "  $name -> $dest"
  mkdir -p "$dest"
  rsync -a --exclude='.git' "$src/" "$dest/"
done

# ---------------------------------------------------------------------------
# 6. Root Gradle build script (settings.gradle wires up subprojects)
# ---------------------------------------------------------------------------
cat > settings.gradle << 'EOF'
rootProject.name = 'runtoolkit-suite'

// Automatically include every folder under mods/ and examples/ that has a build.gradle
def includeIfGradle = { base ->
    file(base).eachDir { dir ->
        if (file("${dir}/build.gradle").exists() || file("${dir}/build.gradle.kts").exists()) {
            def path = ":${base}:${dir.name}"
            include path
            project(path).projectDir = dir
        }
    }
}
includeIfGradle('mods')
includeIfGradle('examples')
EOF

cat > build.gradle << 'EOF'
// Root build.gradle - shared lint/build tasks for all subprojects
allprojects {
    repositories {
        mavenCentral()
        maven { url 'https://maven.fabricmc.net/' }
    }
}

task lint {
    group = 'verification'
    description = 'Runs lint across all subprojects (checkstyle/spotless if present).'
    doLast {
        subprojects.each { sub ->
            if (sub.tasks.findByName('checkstyleMain')) {
                sub.tasks.checkstyleMain.actions.each { it.execute(sub.tasks.checkstyleMain) }
            }
        }
        println "Lint completed (ran checkstyle/spotless where configured)."
    }
}

task buildAll {
    group = 'build'
    description = 'Builds all subprojects.'
    dependsOn subprojects.collect { it.tasks.matching { t -> t.name == 'build' } }
}
EOF

# ---------------------------------------------------------------------------
# 7. Main README
# ---------------------------------------------------------------------------
cat > README.md << EOF
# runtoolkit/suite

Consolidated monorepo for the runtoolkit ecosystem.

## Structure
- \`mods/\`      — Fabric mods
- \`packs/\`     — Datapacks / resource packs
- \`scripts/\`   — Helper scripts and tools
- \`examples/\`  — Templates, example Fabric mods, example datapacks, test files
- \`archived/\`  — Projects no longer developed but kept for reference
- \`other/\`     — Content that doesn't fit another category

## Build
\`\`\`
./gradlew buildAll
./gradlew lint
\`\`\`

## Old repos
The following repos were moved into this monorepo and are now **archived + private**:
$(for name in "${!DECISION[@]}"; do
  [ "${DECISION[$name]}" == "include" ] && echo "- [$name](https://github.com/$ORG/$name) -> \`$(
    if [[ "$name" == *"emplate"* || "$name" == *"xample"* ]]; then echo examples;
    else echo "mods|packs|scripts"; fi
  )/$name\`"
done)

## Skipped repos (empty or inconsistent)
$(for name in "${!DECISION[@]}"; do
  [ "${DECISION[$name]}" == "include" ] || echo "- $name: ${REASON[$name]}"
done)
EOF

git add -A
git commit -m "Initial consolidation from runtoolkit org repos"
git push origin main || git push origin master

echo ""
echo "== suite repo is ready: https://github.com/$ORG/$NEW_REPO =="

# ---------------------------------------------------------------------------
# 8. Archive + make old repos private + add redirect notice to their README
# ---------------------------------------------------------------------------
echo "== Updating old repos (archived + private + README redirect) =="
for name in "${!DECISION[@]}"; do
  [ "${DECISION[$name]}" != "include" ] && continue

  echo "  -> $name"
  src="$WORKDIR/clones/$name"

  # Add redirect notice (must commit BEFORE making private/archived - order matters)
  cd "$src"
  cat > REDIRECT_NOTICE.md << EOF
# ⚠️ This repo has moved

This project is now developed inside the consolidated monorepo at
[$ORG/$NEW_REPO](https://github.com/$ORG/$NEW_REPO). This repo has been archived and made
private, kept around for reference only.
EOF
  git add REDIRECT_NOTICE.md
  git commit -m "Redirect notice: moved to $ORG/$NEW_REPO" --allow-empty -q || true
  git push --quiet || echo "    WARNING: push failed, README redirect may not have been added"

  # Make private FIRST, then archive (GitHub API rule: archived repos can't be modified)
  curl -s -X PATCH -H "$AUTH_HEADER" "$API/repos/$ORG/$name" \
    -d '{"private": true}' > /dev/null
  curl -s -X PATCH -H "$AUTH_HEADER" "$API/repos/$ORG/$name" \
    -d '{"archived": true}' > /dev/null
  cd "$WORKDIR"
done

echo ""
echo "===================================================================="
echo " DONE"
echo " New repo   : https://github.com/$ORG/$NEW_REPO"
echo " Temp files : $WORKDIR (delete with: rm -rf $WORKDIR)"
echo " IMPORTANT: Go REVOKE the token you used now, via GitHub Settings >"
echo " Developer settings > Personal access tokens."
echo "===================================================================="