
# macroEngine (v26.3)

> ⚠️ **Archived.** This datapack is archived and no longer maintained. The `runtoolkit/suite` datapacks are being superseded by [Fabric](https://fabricmc.net/) mods. Existing worlds using this pack will continue to work, but no new features or fixes are planned.

**macroEngine** is a macro/module framework datapack for Minecraft Java Edition, providing a large library of reusable command-based systems (math, string, NBT, geo, permissions, UUID cache, hooks, rate limiting, and more) plus a multi-source text/value input system (dialogs, books, signs, lecterns, name tags, command block minecarts).

> Owner: [runtoolkit](https://github.com/runtoolkit)
> Minecraft: **26.3** (`pack_format` / `min_format`–`max_format` **121**)
> License: MIT
> Namespace: `macroengine`

---

## Features

- **API layer** (`api/`) — stable public entry points: `cmd`, `cb` (callback queue), `color`, `dialog`, `gamerule`, `interaction`, `item`, `macro`, `perm`, `title`, `toggle`, `trigger`, `wand`
- **Systems layer** (`systems/`) — internal utility modules: `math`, `string`, `nbt`, `logic`, `geo`, `flag`, `hook`, `log`, `rate_limit`, `sound`, `uuid`, `color`
- **Input system** (`input/`) — capture player-provided values via writable book, sign, lectern, name tag, dialog, or command block minecart, with shared validation (`input/validate`) for int/float/bool/tag-safe strings
- **GUI module** (`gui/`) — chest-minecart menu framework ported from [`runtoolkit/guikit-datapack`](https://github.com/runtoolkit/guikit-datapack): widgets (button, toggle, counter, cycle, progress, radio, meter), conditions, container registry, extension via `#macroengine:gui/*` tags. See *GUI module* below.
- **Toggle system** — per-module runtime enable/disable for `cb`, `perm`, `geo`, `wand`, `interaction`, `hook`, `gui`, and `experimental` features
- **Rate limiting** — global, per-player, and per-channel request throttling
- **Hook system** — bind functions to fire on events such as block break, dimension change, and advancement grant
- **Item modifiers** (`item_modifier/`) — reusable `item_modifier` definitions for enchanting, glint, lore, tooltip, and rename operations
- **Advancement-driven triggers** (`advancement/`) — core, hidden, and system advancements used to drive internal logic and hooks
- **Experimental namespace** — gated behind `toggle/experimental`, for features not yet considered stable

---

## Requirements

- Minecraft Java Edition **26.3**
- Datapack `min_format`/`max_format`: **121**

---

## Installation

1. Place the datapack folder in your world's `datapacks/` directory (or load it via a server-side pack source).
2. Run `/reload` or restart the server.
3. macroEngine initializes automatically via `#macroengine:events/on_load`.

To manually check load state or configuration, see `data/macroengine/function/config/` and `data/macroengine/function/debug/`.

---

## Usage

Most functionality is exposed through the `api/` namespace, e.g.:

```mcfunction
function macroengine:api/cmd/actionbar
function macroengine:api/dialog/show
function macroengine:api/perm/grant
function macroengine:api/wand/give
```

Internal systems under `systems/` are used by API functions and are not intended to be called directly by end users, though they remain accessible for advanced/custom integrations.

---

## GUI module

Ported from `runtoolkit/guikit-datapack`. Menus are drawn onto a `chest_minecart` (or another registered container)
and clicks are detected by widget items landing in the player's inventory.

**Mapping from guikit:**

| guikit | macroEngine |
|---|---|
| `guikit:<path>` (function) | `macroengine:gui/<path>` |
| `#guikit:register` `fill` `probe` `clear_tags` `on_close` | `#macroengine:gui/register` `fill` `probe` `clear_tags` `on_close` |
| `#guikit:container` (entity type tag) | `#macroengine:gui/container` |
| storage `guikit:in` `w` `cond` `btn` `ctx` … | storage `macroengine:gui_in` `gui_w` `gui_cond` `gui_btn` `gui_ctx` … |
| objectives / entity tags `guikit.<x>` | `macroengine.gui_<x>` |
| NBT `custom_data={guikit:{w:1b}}` | `custom_data={macroengine:{gui:{w:1b}}}` |

**Integration:** loaded from `core/internal/load/loader/other`, ticked from `core/tick/player_systems`, toggled with
`api/toggle/gui/{true,false}` (`modules.gui`). Disabling the module closes all open menus first.

**Opening a menu:**
```mcfunction
function macroengine:gui/internal/clear_in
data merge storage macroengine:gui_in {menu:"ns:id"}
function macroengine:gui/api/open
```
Register menus from a listener added to `#macroengine:gui/register`. The five `#macroengine:gui/*` tag files must stay
`{"values": []}` **without `replace: true`**, and must exist even when empty.

**Security — read before enabling `strict_gating`:**
- Button `cmd` (`gui/internal/btn_cmd`) is routed through `core/internal/security/check_all {required:"cmd_min_level"}`.
  With `flags.experimental.strict_gating` **off** (default) that gate always passes, so it enforces **nothing**.
  With it **on**, the *clicking* player needs `macroengine.perm_level >= security.cmd_min_level` or the
  `macroengine.admin` tag. The effective default of `cmd_min_level` is **0** (`config.mcfunction` runs first and creates
  `security` before `loader/storages` can apply its documented `3`), so even with `strict_gating` on, everyone passes
  until you raise it: `data modify storage macroengine:engine security.cmd_min_level set value 3`. Raising it means
  ordinary players cannot use command buttons at all, including the demo's `give` buttons.
- `cmd` / `url` / `sound` are macro-expanded raw. They must come from menu code, never from player input
  (including values captured through `input/*`).

**Validation status:** all `function` references resolve, `mecha` reports no new errors (the two it reports on
`world/get_time` and `world/time_phase` also occur on the unmodified pack), and all 82 macro lines linted after sample
expansion. **Not verified in a real Minecraft 26.3 client.** guikit's own README lists an unresolved inventory-wipe bug
(`clear @s *[custom_data~...]`) and several untested features; those carry over. Run
`/execute as @s run function macroengine:gui/internal/selftest` in a throwaway world before use.

---

## Notes

- This is the 26.3 line of macroEngine, part of the `runtoolkit/suite` monorepo (`packs/macroEngine-Datapack-v26.3`).
- Experimental features are opt-in via `api/toggle/experimental/true` and are not guaranteed stable between versions.

---

## License

MIT — see the repository [LICENSE](https://github.com/runtoolkit/suite/blob/main/LICENSE).