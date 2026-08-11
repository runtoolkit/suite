# dp-depman — Datapack Dependency Manager

A Gradle-inspired dependency management system for Minecraft Java Edition datapacks.

---

## File layout

```
your-project/
├── datapack_depends.json        ← Dependency config (you edit this)
├── datapack_depends.lock        ← Pinned resolved versions (commit this, never hand-edit)
├── scripts/
│   └── dp-resolve.py            ← CLI resolver tool (no external deps — stdlib only)
├── .github/workflows/
│   ├── datapack-build.yml       ← Main CI/CD pipeline
│   └── dep-update.yml           ← Weekly automated update check
├── deps/                        ← Git submodules land here
│   └── some-lib/
└── example-pack/                ← Example datapack (reference implementation)
```

---

## datapack_depends.json schema

```jsonc
{
  "id": "my-pack",           // Unique pack identifier
  "version": "1.0.0",        // SemVer string
  "description": "...",

  "build": {
    "output": "both"         // "separate" | "merged" | "both"
  },

  "dependencies": {

    // Production dependency — resolved from GitHub Releases
    "dataLib": {
      "source": "github",
      "repo": "runtoolkit/dataLib",
      "version": ">=26.2.0",
      "asset": "dataLib.zip"   // optional; first .zip asset used if omitted
    },

    // Development dependency — resolved from a local git submodule
    "my-lib": {
      "source": "submodule",
      "path": "deps/my-lib",
      "url": "https://github.com/owner/my-lib.git",
      "version": ">=1.0.0"
    }
  }
}
```

### Version constraint formats

| Format     | Meaning                          |
|------------|----------------------------------|
| `1.2.3`    | Exact version                    |
| `>=1.2.0`  | This version or higher           |
| `1.2.x`    | Wildcard patch (`1.2.*`)         |
| `^1.2.0`   | Compatible with `1.x.x`          |
| `~1.2.0`   | Approximately `1.2.x`            |

---

## CLI usage

```bash
# Check version constraints only (no ZIP produced)
python scripts/dp-resolve.py check

# Resolve from GitHub releases (prod), write lock file
python scripts/dp-resolve.py resolve --mode prod

# Resolve from git submodules (dev), write lock file
python scripts/dp-resolve.py resolve --mode dev

# Build — separate ZIPs (one per dep + main pack)
python scripts/dp-resolve.py build --output separate

# Build — single merged ZIP
python scripts/dp-resolve.py build --output merged

# Build — both
python scripts/dp-resolve.py build --output both

# Add submodule dependencies listed in config
python scripts/dp-resolve.py init
```

**Environment variables**

| Variable       | Description                                    |
|----------------|------------------------------------------------|
| `GITHUB_TOKEN` | Required for private repos; increases API rate |

---

## GitHub Actions

### Tag push → automatic release

```bash
git tag v1.2.3
git push origin v1.2.3
```

Pipeline steps:
1. Resolves all dependencies in prod mode
2. Produces `separate` + `merged` ZIPs
3. Commits updated lock file to `main`
4. Creates a GitHub Release with all ZIPs attached

### Pull request → version check only

Checks constraint compatibility on every PR. No build, no ZIPs.

### Scheduled update check (every Monday)

Resolves latest compatible versions, opens a PR if the lock file changes.

---

## Submodule workflow

```bash
# Initial setup — adds all submodule deps from config
python scripts/dp-resolve.py init

# Update all submodules to latest remote commits
git submodule update --remote

# Clone a repo that uses submodules
git clone --recurse-submodules <repo-url>
```

---

## Output modes

### Separate ZIPs (recommended)

Every dependency gets its own ZIP alongside the main pack ZIP.
Drop all of them into `world/datapacks/` — Minecraft handles load order correctly.
No namespace conflicts.

### Merged ZIP

Everything merged into a single ZIP.
Convenient for distribution, but if two dependencies write to the same path
(e.g. `data/minecraft/tags/function/load.json`) one will silently win.
The main pack always overrides dependencies.
Build output lists any conflicts as warnings.

---

## Known limitations

**No transitive dependency resolution.**
If `dataLib` declares its own dependencies, this tool does not follow them.
You must list all required packs explicitly in your config.

**Submodule version detection is best-effort.**
Version is read from the submodule's own `datapack_depends.json`, then from
`pack.mcmeta`. If neither exists, constraint checking is skipped.

**Merged ZIP has no conflict resolution strategy.**
Last writer wins (main pack overrides deps, earlier deps are overridden by later ones).
