# RTWrapper

A custom-command wrapper/queue mod with a gated permission system, audit log, and Chest GUI. Rewritten from scratch in Java, inspired by the command-queueing idea of the original RTWrapper datapack.

*(Description automatically extracted from `src/main/resources/fabric.mod.json`.)*

## Metadata

**Source:** `src/main/resources/fabric.mod.json`
- **Declared dependencies:** `fabricloader: >=0.16.14`, `fabric-api: *`, `minecraft: ~1.21.1`, `java: >=21`
- **License (from fabric.mod.json):** MIT

## Modules

### Java

> RTWrapper - Fabric mod for Minecraft 1.21.1. Inspired by the conceptual idea behind the original RTWrapper datapack (a macro-command wrapper/queue API), rewritten from scratch in Java with the additional features requested by the user:   - OP-level gate (configurable per command, 0-4)   - Audit log to both the console and config/rtwrapper/audit.log   - Chest GUI (/cmdname menu) - lists registered commands and runs them on click   - /cmdname subcommand tree (register/unregister/list/run/menu/reload)     instead of /trigger The 400+ mcfunction variants in the datapack (data/rtwrapper/function/core/wrappers/internal/variants/) were not ported one-to-one; the functionality they covered (running parameterized vanilla commands) is handled by a single general mechanism instead: every line in RegisteredCommand.actions is run directly via server.getCommandManager().executeWithPrefix(...) (see queue.CommandExecutor). This replaces RTWrapper's "generate a separate macro variant per command" approach with a simpler design that lets Brigadier handle its own argument parsing.

- `com.runtoolkit.rtwrapper.RTWrapperMod`
- `com.runtoolkit.rtwrapper.audit.AuditLog`
- `com.runtoolkit.rtwrapper.command.CmdNameCommand`
- `com.runtoolkit.rtwrapper.command.RTWrapperCommands`
- `com.runtoolkit.rtwrapper.gui.CommandMenu`
- `com.runtoolkit.rtwrapper.permission.PermissionGate`
- `com.runtoolkit.rtwrapper.queue.CommandExecutor`
- `com.runtoolkit.rtwrapper.storage.CommandRegistry`
- `com.runtoolkit.rtwrapper.storage.RegisteredCommand`

## Source

- Path in repo: `mods/rtwrapper-mod`
- [View on GitHub](https://github.com/runtoolkit/suite/tree/main/mods/rtwrapper-mod)
- This sub-project has no README.md; this page was generated entirely from metadata files and source code comments.

---
_This page was generated automatically by `generate_wiki.py` from the README, package metadata, and source code of this sub-project. Manual edits will be overwritten the next time the script runs._