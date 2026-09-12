# Datapack Fixer

A **Fabric 1.21.4 server-safe diagnostic mod** for datapack syntax migration. It deliberately does not rewrite pack files, intercept datapack loading, patch network packets, or change gameplay. It only reads unpacked datapacks when the integrated or dedicated server starts and emits diagnostics to the server log.

## Metadata

**Source:** `src/gametest/resources/fabric.mod.json`
- **Declared dependencies:** `fabricloader: *`, `fabric-api: *`, `minecraft: 1.21.4`

**Source:** `examples/datapack-fixer-sample-1.21.4/pack.mcmeta`
- **Pack format:** 61

## Modules

### Java

- `io.runtoolkit.datapackfixer.DatapackFixerClientGameTests`
- `io.runtoolkit.datapackfixer.DatapackFixerGameTests`
- `io.runtoolkit.datapackfixer.DatapackFixerEngine`
- `io.runtoolkit.datapackfixer.DatapackFixerMod`
- `io.runtoolkit.datapackfixer.DatapackSyntaxScanner`
- `io.runtoolkit.datapackfixer.Diagnostic`
- `io.runtoolkit.datapackfixer.DatapackSyntaxScannerTest`

## Source

- Path in repo: `mods/datapack-fixer`
- [View on GitHub](https://github.com/runtoolkit/suite/tree/main/mods/datapack-fixer)
- Full README: [README.md](https://github.com/runtoolkit/suite/tree/main/mods/datapack-fixer/README.md)

---
_This page was generated automatically by `generate_wiki.py` from the README, package metadata, and source code of this sub-project. Manual edits will be overwritten the next time the script runs._