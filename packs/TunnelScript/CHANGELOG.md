# Changelog

All notable changes to this project are documented here. This project adheres
to a strict `MAJOR.MINOR.PATCH` version scheme (two dots, three numbers).

## [1.0.4] - 2026-05-30

### Added

- `ts:run_if` — run an action list only when a condition passes. The `if` field
  is whatever you'd write after `execute if` (use `unless ...` to negate).
- `ts:run_as` — run an action list as/at the entities matched by `selector`.
- `ts:run_after` — run an action list once after a `/schedule` delay. One-shot,
  keeps only the most recently scheduled list, never reschedules itself.
- New `ts_util` namespace with standalone helpers:
  - math: `clamp`, `min`, `max`, `abs`, `random`
  - entity: `count`, `tag_area`
  - text: `join`
  - data: `list_length`, `copy`
  - time: `gametime`, `daytime`

### Fixed

- The `tunnelScript.menu` trigger was usable at all times, even with the menu
  closed. It's now gated on a `tsMenuOpen` tag: `ts:menu` adds the tag and
  enables the trigger, `ts:menu/close` removes it and disables it. No tag means
  the trigger does nothing.

### Changed

- The `tunnelScript.use` / `tunnelScript.menu` triggers now map values **10+**
  to the rest of the API: 10 `ts:run_if`, 11 `ts:run_as`, 12 `ts:run_after`,
  13 `ts:menu`, 14 `ts:menu/close`, and (1.21.6 build) 15 `ts:dialog/open_dynamic`.
- README rewritten in a plainer, first-person style and expanded to cover the
  new 1.0.4 features.

### Added (1.21.6 build)

- `ts:menu/to_dialog` — closes the sidebar (calls `ts:menu/close`) and then opens
  the dialog menu (`ts:dialog/open_dynamic`). `menu_build` carries a `[NOTE]`
  comment pointing at it.

## [1.0.3] - 2026-05-30

### Added

- New `1.21.6` build (data pack format 80) targeting Minecraft 1.21.6.
- In-world hologram label on every build: `ts:hologram/spawn`, `remove` and
  `set_name`, implemented with a marker (invisible `Marker:1b` armor stand) +
  the tag `tunnelscript_menu` + a `CustomName` text component. `CustomName` is
  encoded per target (JSON string up to 1.21.4, inline SNBT from 1.21.5).
- Dialog menus on the `1.21.6` build using the new `/dialog` command:
  `ts:dialog/open_dynamic` and `ts:dialog/open_group` (both take the dialog from
  `storage tunnelscript:in "dialog"` as an inline JSON definition for dynamic
  titles/bodies/lists/buttons and localization, or a registered `ns:path`) and
  `ts:dialog/close`. Includes the `tunnelscript_core:handlers/dialog` macro
  `$dialog show @a[tag=_dialogMenu.open] $(dialog)`.

### Changed

- The sidebar menu is now built **lazily** on first `ts:menu` instead of on
  load. Nothing is created or displayed on (re)load, so reloads stay completely
  silent. `ts:menu/rebuild` still forces a rebuild.

### Fixed

- README dynamic-dialog example used `message` for a `minecraft:plain_message`
  body, which is invalid (1.21.6 requires the `contents` key, a text component).
  Updated to `contents` and documented it.

### Docs

- Dialog guidance now recommends **inline SNBT** definitions over registered
  `ns:path` ids: inline cannot break if a `ts:*` dialog file is removed and it
  avoids the experimental-feature warning. Added guidance to bind dialog buttons
  to `/trigger tunnelScript.use set <n>` (permission level 0) so non-op players
  get no command-confirmation prompt.

### Removed

- All test/demo functions: the built-in example dialogs (`ts:dialog/open`,
  `data/ts/dialog/example.json`, `data/ts/dialog/example_custom.json`). Dialogs
  are now always supplied by the caller.

### Fixed

- Sidebar menu no longer relies on score-holder names that contain spaces.
  Each line now uses a clean, space-free holder (`ts.l1`..`ts.l12`) and its
  visible text is set with `scoreboard players display name` (a full text
  component), which properly supports spaces and colours on every target.
  (A marker/armor-stand `CustomName` approach was considered but does not work:
  the sidebar cannot render an entity's CustomName, it shows the UUID instead.)

### Changed

- The build generator is now text-format aware. Minecraft 1.21.5+ requires SNBT
  (not JSON) text components in commands such as `/tellraw` and `/title`, so the
  1.21.6 build emits SNBT for all in-command messages and the scoreboard menu
  title. Builds for 1.21.4 and earlier continue to emit JSON. The public API
  input format (`data merge storage tunnelscript:in {...}`) is unchanged on all
  versions.

## [1.0.2] - 2026-05-30

### Added

- Sidebar menu system. `ts:menu` opens an on-screen menu in the scoreboard
  sidebar; `ts:menu/close` hides it and `ts:menu/rebuild` refreshes it. Options
  are selected with `/trigger tunnelScript.menu set <n>` and the menu stays open
  after a selection. It deliberately avoids `tellraw` (no chat/log spam) and a
  written book (whose syntax changes between versions); labels use stable legacy
  colour codes and the score numbers are hidden with `numberformat blank`.

## [1.0.1] - 2026-05-30

### Added

- Per-command action handlers in `tunnelscript_core`, including `handlers/give`,
  so any common command can be used directly as an action `type` in `ts:run`
  (for example `{"type":"give","value":"@p minecraft:diamond 64"}`).
- Public `/trigger tunnelScript.use set <n>` binding that maps to the `ts:`
  functions, usable without command permissions. The trigger objective is
  registered on load and re-armed automatically.

### Fixed

- `pack.png` was a JPEG with a `.png` extension, causing "Bad PNG Signature" in
  game. It is now a valid 128x128 PNG.
- README mixed-action example used backslash line continuations that broke when
  pasted; it is now a single clean line, with clearer guidance.
- README input examples used `data modify storage ... set value` at the root,
  which is invalid (a path is required before `set`). They now use
  `data merge storage tunnelscript:in {...}`.

## [1.0.0] - 2026-05-30

### Added

- Public API in the `ts` namespace:
  - `ts:run` — process a typed, mixed action list in one bounded pass.
  - `ts:run_command` — run one command (`command` / `cmd` / `func` aliases).
  - `ts:run_commands` — run many commands in one pass.
  - `ts:run_function` — run one function with an argument source
    (`$function $(func) with $(type) $(val)`).
  - `ts:run_functions` — run many no-argument functions in one pass.
  - `ts:multi/<command>` — convenience wrappers for every common command.
  - `ts:config/*` — configurable cooldown and per-run action cap.
  - `ts:version`, `ts:help`.
- Internal `tunnelscript_core` namespace with the macro handlers, dispatcher,
  bounded iterators, and the cooldown guard.
- `minecraft` load/tick tags. The tick hook performs no work and never repeats.
- Documentation: README, security policy, support/issue/PR templates, and a CI
  workflow that blocks committed secrets.

### Security

- The raw command macro `$$(command)` is internal only.
- Built-in safety limits: configurable cooldown and a hard action cap per run.
- No automatic looping or repeating execution.
- No telemetry, no data collection, and no embedded credentials.
