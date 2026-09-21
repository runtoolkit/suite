> **⚠️ ARCHIVED / MOVED**
>
> This repository (`runtoolkit/suite`) is **archived** and no longer maintained.
>
> All further development continues at:
> **https://github.com/vortacraftmc/core**
>
> Please open issues, PRs, and use the latest releases from the new repository.
> This repo is kept only as a historical snapshot.

# Changelog

All notable changes to this project are documented here. This project adheres
to a strict `MAJOR.MINOR.PATCH` version scheme (two dots, three numbers).

This file covers the **1.19.2 build** (`pack_format: 10`) of TunnelScript.
Other Minecraft versions are separate builds/branches with their own version
history.

## [1.1.0] - current

The pack previously shipped two divergent, incompatible function trees in
the same namespaces (one for a 1.21.1 build, one for this 1.19.2 build). The
1.21.1 tree has been removed from this pack; only the 1.19.2 build documented
below remains here.

### Present in this build

- **Command running:** `ts:run` (typed `cmd`/`command` actions only - no
  macro-based dispatch on 1.19.2), `ts:run_command`, `ts:run_commands`, all
  backed by a command-block-minecart runner (`tunnelscript_core:internal/run_block`
  and friends).
- **Trust + confirmation gate:** dangerous actions require the
  `tunnelscript.trusted` tag (`ts:trust/grant` / `ts:trust/revoke`) and a
  confirm/cancel step (`ts:gate/yes` / `ts:gate/cancel`) before they run.
- **Command batches:** 9 fixed named slots (`ts:batch/save`, `load`, `run`,
  `delete`, `list`).
- **Minecart input module:** captures commands from a tagged
  `command_block_minecart`'s `Command` field into a queue, with pause/resume,
  silent mode, history, and stats (`ts:input/*`).
- **Dry-run preview:** `ts:dryrun/on`/`off`/`status`/`reset_count` - preview
  commands without touching the world.
- **Command log + repeat:** `ts:log/on`/`off`/`show`/`last`/`clear`/`set_max`,
  and `ts:repeat` to re-run the last executed command.
- **Configuration:** cooldown and per-run action cap (`ts:config/*`).
- **Hologram label:** floating in-world menu label via an invisible marker
  armor stand (`ts:hologram/*`).
- **`ts_util` helpers:** math (`clamp`/`min`/`max`/`abs`/`random`), entity
  (`count`/`tag_area`), text (`join`), storage (`list_length`/`copy`), and
  time (`gametime`/`daytime`).
- **`/trigger tunnelScript.use`** access for non-operators, covering
  `version`, `help`, `run`, `run_command`, `run_commands`, `config/get`,
  `config/reset`.

### Known gaps vs. newer builds

Anything requiring function macros - `run_function` with arguments, `run_if`,
`run_as`, `run_after`, dialog menus, and per-command `multi/<command>`
wrappers beyond raw `commands`/`actions` - needs Minecraft 1.20.2+ and isn't
present on this build.

## Earlier history

Not preserved for this build. The version history previously recorded in
this file (entries 1.0.0 through 1.0.4) documented a different, 1.21.1-target
build of TunnelScript that has been removed from this pack - see the note
above.

## License

[Unlicense](LICENSE) (public domain).
