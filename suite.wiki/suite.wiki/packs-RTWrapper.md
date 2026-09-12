# RTWrapper

RTWrapper is a datapack for Java Edition 26.2.

## Metadata

**Source:** `rtwrapper-fabric/src/main/resources/fabric.mod.json`
- **Declared dependencies:** `fabricloader: >=0.16`, `fabric-api: *`, `minecraft: ~1.21.1`
- **License (from fabric.mod.json):** MIT

**Source:** `datapack/RTWrapper-Datapack/pack.mcmeta`
- **Pack format:** 107
- **Enabled features:** minecraft:vanilla

## Modules

### Java

> Records every dispatch attempt: who, when, what command, and the outcome. The datapack had no equivalent — the only trace of a wrapper call was whatever scoreboard counters load.mcfunction set up (#rtw.processed / #rtw.errors, mirrored here by RTWrapperConfig), which tell you *how many* things ran, never *what* or *by whom*. That made the datapack's permission gap (see RTCommand's Javadoc) unauditable even after the fact — an op-level command dispatched by an unintended caller left no record beyond the raw increment. Kept as a bounded in-memory ring buffer plus a logger line per entry. Not a database or file-backed store on purpose: RTWrapper has no persistence layer elsewhere (RTWrapperConfig's counters are also in-memory only, reset on restart), so this matches the mod's existing durability guarantees rather than introducing a new one. Server owners who need a durable trail already get one for free via the logger line, which lands wherever the server's own log configuration sends it.

- `com.runtoolkit.rtwrapper.RTWrapper`
- `com.runtoolkit.rtwrapper.api.AuditLog`
- `com.runtoolkit.rtwrapper.api.CommandCooldown`
- `com.runtoolkit.rtwrapper.api.PermissionOverrides`
- `com.runtoolkit.rtwrapper.api.RTDispatchResult`
- `com.runtoolkit.rtwrapper.api.RTRequest`
- `com.runtoolkit.rtwrapper.api.RTWrapperAPI`
- `com.runtoolkit.rtwrapper.api.RTWrapperConfig`
- `com.runtoolkit.rtwrapper.api.RateLimiter`
- `com.runtoolkit.rtwrapper.api.ScheduledDispatch`
- `com.runtoolkit.rtwrapper.command.RTCommand`
- `com.runtoolkit.rtwrapper.command.RTWrapperCommand`

## Source

- Path in repo: `packs/RTWrapper`
- [View on GitHub](https://github.com/runtoolkit/suite/tree/main/packs/RTWrapper)
- Full README: [README.md](https://github.com/runtoolkit/suite/tree/main/packs/RTWrapper/README.md)

---
_This page was generated automatically by `generate_wiki.py` from the README, package metadata, and source code of this sub-project. Manual edits will be overwritten the next time the script runs._