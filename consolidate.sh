#!/usr/bin/env bash
# runtoolkit -> suite konsolidasyon script'i
# Kullanım: GITHUB_TOKEN=ghp_xxx ./consolidate.sh
#
# Bu script SENİN makinende çalışır. Token asla Claude'a veya başka bir yere gönderilmez.
set -euo pipefail

if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "HATA: GITHUB_TOKEN env değişkeni set değil."
  echo "Kullanım: GITHUB_TOKEN=ghp_xxx ./consolidate.sh"
  exit 1
fi

ORG="runtoolkit"
NEW_REPO="suite"
WORKDIR="$(mktemp -d)"
API="https://api.github.com"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

echo "Çalışma dizini: $WORKDIR"
cd "$WORKDIR"

# ---------------------------------------------------------------------------
# 1. Repo listesini çek
# ---------------------------------------------------------------------------
echo "== Repo listesi çekiliyor =="
curl -s -H "$AUTH_HEADER" "$API/orgs/$ORG/repos?per_page=100" > repos.json
python3 -c "
import json
repos = json.load(open('repos.json'))
for r in repos:
    print(r['name'])
" > repo_names.txt
echo "$(wc -l < repo_names.txt) repo bulundu."

# ---------------------------------------------------------------------------
# 2. Her repoyu clone et ve analiz et (boş / tutarsız tespiti)
# ---------------------------------------------------------------------------
mkdir -p clones
declare -A DECISION   # repo -> "include" | "skip-empty" | "skip-stale"
declare -A REASON

echo "== Repolar clone ediliyor ve analiz ediliyor =="
while read -r name; do
  [ -z "$name" ] && continue

  # Manuel olarak atlanacaklar (kullanıcı ile netleşen)
  if [ "$name" == "DataLibFabric" ]; then
    DECISION[$name]="skip-empty"; REASON[$name]="1KB, boş/placeholder (manuel onaylı)"
    continue
  fi

  echo "  -> $name"
  if ! git clone --quiet "https://x-access-token:${GITHUB_TOKEN}@github.com/${ORG}/${name}.git" "clones/$name" 2>/tmp/clone_err; then
    DECISION[$name]="skip-error"; REASON[$name]="clone başarısız: $(cat /tmp/clone_err | tail -1)"
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

  # Boş repo (sadece .gitignore/LICENSE gibi dosyalar veya hiç dosya)
  if [ "$file_count" -le 2 ]; then
    DECISION[$name]="skip-empty"; REASON[$name]="sadece $file_count dosya"
    continue
  fi

  # 1 yıldan eski VE archived değilse "muhtemelen terk edilmiş" -> flag et ama otomatik atlama,
  # kullanıcı onayı olmadan sessizce atlamıyoruz. Rapora yazıyoruz.
  DECISION[$name]="include"; REASON[$name]="dosya=$file_count son_commit=$last_commit_date archived=$is_archived readme=$has_readme"

done < repo_names.txt

# ---------------------------------------------------------------------------
# 3. Karar raporunu yazdır ve kullanıcıdan onay iste (interaktif)
# ---------------------------------------------------------------------------
echo ""
echo "======================================================================"
echo " ANALİZ RAPORU - suite/ deposuna dahil edilecek/edilmeyecek repolar"
echo "======================================================================"
for name in "${!DECISION[@]}"; do
  printf "%-30s %-12s %s\n" "$name" "${DECISION[$name]}" "${REASON[$name]}"
done | sort

echo ""
read -p "Bu kararlarla devam edilsin mi? (evet/hayır): " confirm
if [ "$confirm" != "evet" ]; then
  echo "İptal edildi. clones/ ve repos.json dosyalarını $WORKDIR altında inceleyip"
  echo "script içindeki DECISION dizisini elle düzenleyip tekrar çalıştırabilirsin."
  exit 0
fi

# ---------------------------------------------------------------------------
# 4. Yeni suite reposunu oluştur
# ---------------------------------------------------------------------------
echo "== $ORG/$NEW_REPO oluşturuluyor =="
curl -s -X POST -H "$AUTH_HEADER" "$API/orgs/$ORG/repos" \
  -d "{\"name\":\"$NEW_REPO\",\"description\":\"Consolidated runtoolkit monorepo: mods, packs, scripts, examples\",\"private\":false,\"auto_init\":true}" \
  > create_result.json
echo "Oluşturuldu: $(python3 -c "import json; print(json.load(open('create_result.json')).get('html_url','HATA - create_result.json dosyasına bak'))")"

git clone --quiet "https://x-access-token:${GITHUB_TOKEN}@github.com/${ORG}/${NEW_REPO}.git" suite
cd suite
mkdir -p mods packs scripts archived other examples

# ---------------------------------------------------------------------------
# 5. Her "include" repoyu kategorize edip taşı (git history KORUNMAZ - dosya kopyası)
#    Not: history korumak istersen git subtree/filter-repo gerekir, bu script
#    basit dosya kopyalama yapar. İstersen sonraki adımda subtree'ye çevirebiliriz.
# ---------------------------------------------------------------------------
echo "== Dosyalar kategorize edilip taşınıyor =="
for name in "${!DECISION[@]}"; do
  [ "${DECISION[$name]}" != "include" ] && continue
  src="$WORKDIR/clones/$name"
  [ ! -d "$src" ] && continue

  # Kategori tahmini: fabric.mod.json varsa mod, pack.mcmeta varsa pack,
  # "template" veya "example" isimde geçiyorsa examples, script/tool ise scripts
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
# 6. Kök Gradle build script'i (settings.gradle ile alt projeleri birleştir)
# ---------------------------------------------------------------------------
cat > settings.gradle << 'EOF'
rootProject.name = 'runtoolkit-suite'

// mods/ ve examples/ altındaki build.gradle içeren her klasörü otomatik dahil et
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
// Kök build.gradle - tüm alt projeler için ortak lint/build task'ları
allprojects {
    repositories {
        mavenCentral()
        maven { url 'https://maven.fabricmc.net/' }
    }
}

task lint {
    group = 'verification'
    description = 'Tüm alt projelerde lint çalıştırır (varsa checkstyle/spotless).'
    doLast {
        subprojects.each { sub ->
            if (sub.tasks.findByName('checkstyleMain')) {
                sub.tasks.checkstyleMain.actions.each { it.execute(sub.tasks.checkstyleMain) }
            }
        }
        println "Lint tamamlandı (alt projelerde checkstyle/spotless tanımlıysa çalıştı)."
    }
}

task buildAll {
    group = 'build'
    description = 'Tüm alt projeleri build eder.'
    dependsOn subprojects.collect { it.tasks.matching { t -> t.name == 'build' } }
}
EOF

# ---------------------------------------------------------------------------
# 7. Ana README
# ---------------------------------------------------------------------------
cat > README.md << EOF
# runtoolkit/suite

runtoolkit ekosisteminin konsolide edilmiş monorepo'su.

## Yapı
- \`mods/\`      — Fabric modları
- \`packs/\`     — Datapack / resource pack'ler
- \`scripts/\`   — Yardımcı script'ler ve tool'lar
- \`examples/\`  — Template'ler, örnek Fabric modları, örnek datapack'ler, test dosyaları
- \`archived/\`  — Artık geliştirilmeyen ama referans için tutulan projeler
- \`other/\`     — Kategorize edilemeyen diğer içerik

## Build
\`\`\`
./gradlew buildAll
./gradlew lint
\`\`\`

## Eski depolar
Aşağıdaki depolar bu monorepo'ya taşındı ve artık **arşivli + private**:
$(for name in "${!DECISION[@]}"; do
  [ "${DECISION[$name]}" == "include" ] && echo "- [$name](https://github.com/$ORG/$name) -> \`$(
    if [[ "$name" == *"emplate"* || "$name" == *"xample"* ]]; then echo examples;
    else echo "mods|packs|scripts"; fi
  )/$name\`"
done)

## Atlanan depolar (boş veya tutarsız)
$(for name in "${!DECISION[@]}"; do
  [ "${DECISION[$name]}" == "include" ] || echo "- $name: ${REASON[$name]}"
done)
EOF

git add -A
git commit -m "Initial consolidation from runtoolkit org repos"
git push origin main || git push origin master

echo ""
echo "== suite reposu hazır: https://github.com/$ORG/$NEW_REPO =="

# ---------------------------------------------------------------------------
# 8. Eski repoları arşivle + private yap + README'lerine yönlendirme ekle
# ---------------------------------------------------------------------------
echo "== Eski repolar güncelleniyor (archived + private + README yönlendirmesi) =="
for name in "${!DECISION[@]}"; do
  [ "${DECISION[$name]}" != "include" ] && continue

  echo "  -> $name"
  src="$WORKDIR/clones/$name"

  # README'ye yönlendirme ekle (önce private yapmadan commit atmak lazım, sıra önemli)
  cd "$src"
  cat > REDIRECT_NOTICE.md << EOF
# ⚠️ Bu depo taşındı

Bu proje artık [$ORG/$NEW_REPO](https://github.com/$ORG/$NEW_REPO) altında konsolide edilmiş
monorepo içinde geliştirilmektedir. Bu depo arşivlenmiş ve private yapılmıştır, referans amaçlı korunmaktadır.
EOF
  git add REDIRECT_NOTICE.md
  git commit -m "Redirect notice: moved to $ORG/$NEW_REPO" --allow-empty -q || true
  git push --quiet || echo "    UYARI: push başarısız, README yönlendirmesi atlanmış olabilir"

  # Önce private yap, SONRA archive et (GitHub API sırası: archived repo değiştirilemez)
  curl -s -X PATCH -H "$AUTH_HEADER" "$API/repos/$ORG/$name" \
    -d '{"private": true}' > /dev/null
  curl -s -X PATCH -H "$AUTH_HEADER" "$API/repos/$ORG/$name" \
    -d '{"archived": true}' > /dev/null
  cd "$WORKDIR"
done

echo ""
echo "===================================================================="
echo " TAMAMLANDI"
echo " Yeni depo : https://github.com/$ORG/$NEW_REPO"
echo " Geçici dosyalar : $WORKDIR (istersen sil: rm -rf $WORKDIR)"
echo " ÖNEMLİ: Kullandığın token'ı şimdi GitHub Settings > Developer settings"
echo " üzerinden REVOKE ET."
echo "===================================================================="
