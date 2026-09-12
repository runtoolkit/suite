# runtoolkit/suite

Consolidated monorepo for the runtoolkit ecosystem.

## Structure

- `mods/`      — Fabric mods
- `packs/`     — Datapacks / resource packs
- `scripts/`   — Helper scripts and tools
- `examples/`  — Templates, example Fabric mods, example datapacks, test files
- `archived/`  — Reserved for projects no longer developed but kept for reference (not currently populated — nothing has been moved here yet)
- `other/`     — Reserved for content that doesn't fit another category (not currently populated)

## Building

This repo uses Gradle to build all Fabric mod subprojects.

### Requirements

- JDK 25
- Gradle Wrapper (included, no separate Gradle install needed)

### Build all subprojects

```bash
./gradlew buildAll
```

This runs the build task across every subproject under `mods/` and produces mod JARs. Output JARs land in each subproject's `build/libs/` directory.

### Lint all subprojects

```bash
./gradlew lint
```

### Build a single subproject

```bash
./gradlew :mods:<subproject-name>:build
```

### CI

Pushes and pull requests trigger the `build.yml` workflow (Build & Lint), which runs `buildAll` and `lint` across all subprojects and uploads build artifacts. See `.github/workflows/build.yml` for the full pipeline, including the release-publishing job.

## Old repos

The following repos were moved into this monorepo and are now **private**:

- [TunnelScript](https://github.com/runtoolkit/TunnelScript)
- [LeftClickDetection](https://github.com/runtoolkit/LeftClickDetection)
- [dp-depman](https://github.com/runtoolkit/dp-depman)
- [RTWrapper](https://github.com/runtoolkit/RTWrapper)
- [datapack-fixer](https://github.com/runtoolkit/datapack-fixer)
- [itemExampleMod](https://github.com/runtoolkit/itemExampleMod)
- [template-datapack](https://github.com/runtoolkit/template-datapack)
- [InteractionClickDetection](https://github.com/runtoolkit/InteractionClickDetection)
- [cmdTunnel-datapack](https://github.com/runtoolkit/cmdTunnel-datapack)
- [dpgen](https://github.com/runtoolkit/dpgen)
- [TEMPLATE-MOD](https://github.com/runtoolkit/TEMPLATE-MOD)
- [inv_gui](https://github.com/runtoolkit/inv_gui)
- [macroEngine](https://github.com/runtoolkit/macroEngine)

## Skipped repos (empty or inconsistent)

- FunctionPP: only 2 file(s)
- DataLibFabric: 1KB, empty/placeholder (manually confirmed)
- .github: only 2 file(s)
