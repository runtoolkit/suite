# dp-depman

Dependency management for Minecraft Java Edition datapacks.

Declare dependencies in `datapack_depends.json`, resolve from GitHub Releases or git submodules, and produce installable ZIPs — locally or via GitHub Actions.

---

## Requirements

- Python 3.12+ (stdlib only — no `pip install`)
- Git (for submodule support)
- `GITHUB_TOKEN` env var (for GitHub Releases resolution)

---

## Quick start

**1. Add `datapack_depends.json` to your datapack repo:**

```json
{
  "id": "my-pack",
  "version": "1.0.0",
  "dependencies": {
    "dataLib": {
      "source": "github",
      "repo": "runtoolkit/dataLib",
      "version": ">=26.2.0",
      "asset": "dataLib.zip"
    }
  }
}
```

**2. Resolve and build:**

```bash
python scripts/dp-resolve.py build --mode prod --output both
```

**3. Install:**

Drop all ZIPs from `dist/` into `world/datapacks/`, then `/reload`.

---

## Dependency sources

### GitHub Releases (`source: github`)

Fetches the highest matching release asset from the GitHub API.
Requires `GITHUB_TOKEN` for private repos or to avoid rate limits.

```json
"dataLib": {
  "source": "github",
  "repo": "runtoolkit/dataLib",
  "version": ">=26.2.0",
  "asset": "dataLib.zip"
}
```

`asset` is optional. If omitted, the first `.zip` asset in the release is used.

### Git Submodule (`source: submodule`)

Uses a local submodule. Intended for packs you develop alongside the main pack.

```json
"my-lib": {
  "source": "submodule",
  "path": "deps/my-lib",
  "url": "https://github.com/owner/my-lib.git",
  "version": ">=1.0.0"
}
```

Run `python scripts/dp-resolve.py init` to add all submodule deps automatically.

---

## Version constraints

| Format    | Meaning                  |
|-----------|--------------------------|
| `1.2.3`   | Exact match              |
| `>=1.2.0` | Minimum version          |
| `1.2.x`   | Wildcard patch           |
| `^1.2.0`  | Major version fixed      |
| `~1.2.0`  | Major + minor fixed      |

---

## CLI reference

```bash
python scripts/dp-resolve.py <command> [options]
```

| Command   | Description                                          |
|-----------|------------------------------------------------------|
| `check`   | Verify constraints; no output produced               |
| `resolve` | Resolve dependencies and write `datapack_depends.lock` |
| `build`   | Resolve + produce ZIPs in `dist/`                   |
| `init`    | Add submodule deps via `git submodule add`           |

| Option              | Values                        | Default  |
|---------------------|-------------------------------|----------|
| `--mode`            | `prod` / `dev` / `auto`       | `auto`   |
| `--output`          | `separate` / `merged` / `both`| `separate`|
| `--config`          | path                          | `datapack_depends.json` |
| `--token`           | string                        | `$GITHUB_TOKEN` |

`--mode auto` uses each dependency's own `source` field to decide.

---

## Output modes

**`separate`** — one ZIP per dependency + one ZIP for the main pack.
Drop all into `world/datapacks/`. No namespace conflicts. Recommended.

**`merged`** — everything in a single ZIP.
Convenient for distribution. The main pack overrides dependencies on conflict;
earlier dependencies are overridden by later ones. Conflicts are printed as warnings.

---

## Lock file

`datapack_depends.lock` records the exact resolved version and SHA-256 of every
dependency. Commit this file. The lock makes builds reproducible — `resolve` updates
it, everything else reads it.

Never edit the lock file by hand.

---

## GitHub Actions

Copy `.github/workflows/` into your repo.

| Trigger            | Job            | What it does                                                    |
|--------------------|----------------|-----------------------------------------------------------------|
| Pull request       | `dep-check`    | Checks version constraints. Fails fast if a constraint breaks. |
| Tag push (`v*.*.*`)| `build`        | Resolves, builds ZIPs, commits lock, creates GitHub Release.   |
| Every Monday       | `check-updates`| Resolves latest versions, opens a PR if the lock changes.      |
| Manual dispatch    | `build`        | Runs build with selectable `--mode` and `--output`.            |

### Release workflow

```bash
git tag v1.2.3
git push origin v1.2.3
```

All ZIPs are attached to the GitHub Release automatically.
Users download and drop them into `world/datapacks/` — no manual dependency
hunting required.

---

## Submodule workflow

```bash
# First-time: add all submodule deps declared in config
python scripts/dp-resolve.py init

# Update submodules to latest remote
git submodule update --remote

# Clone with submodules
git clone --recurse-submodules <url>
```

---

## Project layout

```
dp-depman/
├── README.md
├── datapack_depends.json        ← Config template
├── datapack_depends.lock        ← Pinned versions (commit this)
├── scripts/
│   └── dp-resolve.py            ← Resolver (no external dependencies)
├── .github/
│   └── workflows/
│       ├── datapack-build.yml   ← Build + release pipeline
│       └── dep-update.yml       ← Scheduled update check
└── example-pack/                ← Reference datapack implementation
```

---

## Known limitations

**No transitive resolution.** Dependencies of dependencies are not followed.
List every required pack explicitly.

**Submodule version detection is best-effort.** Version is read from the
submodule's `datapack_depends.json`, then `pack.mcmeta`. If neither is present,
constraint checking is skipped and a warning is printed.

**Merged ZIP has no conflict resolution strategy.** If two dependencies
declare the same file path, last write wins. Check build output for conflict warnings.

---

## License

MIT