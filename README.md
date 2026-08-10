# runtoolkit/suite

Consolidated monorepo for the runtoolkit ecosystem.

## Structure
- `mods/`      — Fabric mods
- `packs/`     — Datapacks / resource packs
- `scripts/`   — Helper scripts and tools
- `examples/`  — Templates, example Fabric mods, example datapacks, test files
- `archived/`  — Projects no longer developed but kept for reference
- `other/`     — Content that doesn't fit another category

## Build
```
./gradlew buildAll
./gradlew lint
```

## Old repos
The following repos were moved into this monorepo and are now **archived + private**:
- [TunnelScript](https://github.com/runtoolkit/TunnelScript) -> `mods|packs|scripts/TunnelScript`
- [LeftClickDetection](https://github.com/runtoolkit/LeftClickDetection) -> `mods|packs|scripts/LeftClickDetection`
- [dataLib-python](https://github.com/runtoolkit/dataLib-python) -> `mods|packs|scripts/dataLib-python`
- [dp-depman](https://github.com/runtoolkit/dp-depman) -> `mods|packs|scripts/dp-depman`
- [RTWrapper](https://github.com/runtoolkit/RTWrapper) -> `mods|packs|scripts/RTWrapper`
- [datapack-fixer](https://github.com/runtoolkit/datapack-fixer) -> `mods|packs|scripts/datapack-fixer`
- [itemExampleMod](https://github.com/runtoolkit/itemExampleMod) -> `examples/itemExampleMod`
- [docs](https://github.com/runtoolkit/docs) -> `mods|packs|scripts/docs`
- [template-datapack](https://github.com/runtoolkit/template-datapack) -> `examples/template-datapack`
- [InteractionClickDetection](https://github.com/runtoolkit/InteractionClickDetection) -> `mods|packs|scripts/InteractionClickDetection`
- [dataLib-next](https://github.com/runtoolkit/dataLib-next) -> `mods|packs|scripts/dataLib-next`
- [dataEngine-dp](https://github.com/runtoolkit/dataEngine-dp) -> `mods|packs|scripts/dataEngine-dp`
- [cmdTunnel-datapack](https://github.com/runtoolkit/cmdTunnel-datapack) -> `mods|packs|scripts/cmdTunnel-datapack`
- [dpgen](https://github.com/runtoolkit/dpgen) -> `mods|packs|scripts/dpgen`
- [dataLib-command](https://github.com/runtoolkit/dataLib-command) -> `mods|packs|scripts/dataLib-command`
- [dataLib-core](https://github.com/runtoolkit/dataLib-core) -> `mods|packs|scripts/dataLib-core`
- [guimaker-fabric](https://github.com/runtoolkit/guimaker-fabric) -> `mods|packs|scripts/guimaker-fabric`
- [datalib-site](https://github.com/runtoolkit/datalib-site) -> `mods|packs|scripts/datalib-site`
- [Datapack-Config-Generator](https://github.com/runtoolkit/Datapack-Config-Generator) -> `mods|packs|scripts/Datapack-Config-Generator`
- [EventCoreSystem-Fabric](https://github.com/runtoolkit/EventCoreSystem-Fabric) -> `mods|packs|scripts/EventCoreSystem-Fabric`
- [TEMPLATE-MOD](https://github.com/runtoolkit/TEMPLATE-MOD) -> `mods|packs|scripts/TEMPLATE-MOD`
- [load](https://github.com/runtoolkit/load) -> `mods|packs|scripts/load`
- [guimaker](https://github.com/runtoolkit/guimaker) -> `mods|packs|scripts/guimaker`
- [dataLib-dp](https://github.com/runtoolkit/dataLib-dp) -> `mods|packs|scripts/dataLib-dp`
- [inv_gui](https://github.com/runtoolkit/inv_gui) -> `mods|packs|scripts/inv_gui`
- [dataLib-FabricMod](https://github.com/runtoolkit/dataLib-FabricMod) -> `mods|packs|scripts/dataLib-FabricMod`
- [dataLib-log](https://github.com/runtoolkit/dataLib-log) -> `mods|packs|scripts/dataLib-log`
- [macroEngine-dp](https://github.com/runtoolkit/macroEngine-dp) -> `mods|packs|scripts/macroEngine-dp`
- [DataLibSite](https://github.com/runtoolkit/DataLibSite) -> `mods|packs|scripts/DataLibSite`

## Skipped repos (empty or inconsistent)
- FunctionPP: only 2 file(s)
- DataLibFabric: 1KB, empty/placeholder (manually confirmed)
- .github: only 2 file(s)
- suite: only 2 file(s)
