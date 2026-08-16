# 🔧 macroEngine

**Minecraft Java Edition 26.2 | Multiplayer-Safe | Pure Datapack**

[![CI](https://github.com/runtoolkit/macroEngine/actions/workflows/ci.yml/badge.svg)](https://github.com/runtoolkit/macroEngine/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

---
> Current version: **v6.0.2**
---

> **This datapack was considered safe to use as of its last release, but it no longer receives security improvements, bug fixes, or new features. There is no "up to date" version to move to.**
>
> **Do not copy `macroengine:input` or `macroengine:engine` into your own datapack.** It is an internal implementation detail and may change without notice between releases.

> ⚠️ **Do not use v5.1.1.** That version bound `_rt_origin.mcfunction` to the load tag, causing it to run automatically on every load with no safe removal path. Fixed in later versions — always use the latest release.

---

> ⚠️ A `/reload` is still required after installation or after adding the load hook below. Automatic first-join initialization is not implemented in this version — do not rely on this until verified in-game with repeated reloads.

---

> 🛡️ **This is a Minecraft Datapack — it contains no executables or scripts outside of `.mcfunction` files.**
> Some antivirus software may flag `.mcfunction` files as suspicious due to macro-like syntax. This is a **false positive**. The pack has been scanned on [VirusTotal](https://www.virustotal.com) and returned clean.
> **Only download from this official repository.** Do not trust redistributed or repackaged versions from third-party sources.

---

## 📦 Installation

1. Download the latest release from the [Modrinth versions page](https://modrinth.com/datapack/macroengine/versions) and place the `.zip` into `<world>/datapacks/`.

2. Add the following logic to your datapack's `load` tag. Replace `<namespace>` with your own datapack's namespace (e.g. `mypack`) — this applies only to the function names, never to `macroengine:engine`, which is MacroEngine's own fixed storage and must not be changed:

```mcfunction
#> <namespace>:load
execute unless data storage macroengine:engine {global:{loaded:1b}} run function <namespace>:load_macroengine
```

```mcfunction
#> <namespace>:load_macroengine

# Guard checks the SAME storage/path the trigger condition checks (macroengine:engine global.loaded).
execute if data storage macroengine:engine {global:{loaded:1b}} run return 0

function macroengine_load:main

data modify storage macroengine:engine global.loaded set value 1b
```

<details>
<summary>Fixed bug: duplicate load trigger (click to expand)</summary>

An earlier version checked `macroengine:engine {global:{loaded:1b}}` in the trigger but set `<namespace>:engine loaded_macroengine` in the guard — two different storages, two different paths. The set never satisfied the trigger's condition, so `load_macroengine` re-ran every time the load tag fired. This doesn't crash anything, but it silently re-triggers `dl_load:load/yes` and `fork_no` on every reload, which can accumulate side effects depending on what those functions do.

Both the check and the set must target `macroengine:engine global.loaded`. If you're updating from an older copy of this README, verify by reloading multiple times and confirming `load_macroengine` does NOT re-run after the first load.

</details>

---

## 🏗️ Storage Architecture

```
macroengine:engine  (persistent data)
├── global
│   ├── version: "v6.0.2"
│   ├── loaded: 1b
│   └── tick: <int>
├── players
│   └── Steve { coins:150, level:5, xp:2300, online:1b, ... }
├── queue
│   └── [{func:"mypack:event/end", delay:100}]
├── cooldowns
│   └── Steve { fireball: 2460, dash: 1870 }  ← expiry ticks
└── events
    └── on_join: [{func:"mypack:welcome"}, {func:"mypack:xp_bonus"}]

macroengine:input   (sending data to a function)
macroengine:output  (receiving results from a function)
```

**Note:** All MacroEngine-owned state lives under the `macroengine:` namespace only. Never mix a consuming pack's own namespace into MacroEngine's load-flag logic — that mismatch was the source of the bug above.

---

## 📦 Dependencies

### Lantern Load
**Repository:** https://github.com/LanternMC/load
**License:** BSD 0-Clause (public domain)

Provides deterministic load order, version tracking, and pre/load/post-load hooks.

```mcfunction
# Check if MacroEngine is loaded
execute if score #MacroEngine load.status matches 1.. run say MacroEngine is loaded

# Get version (major*10000 + minor*100 + patch → v6.0.2 = 601)
scoreboard players get #MacroEngine load.status
```

### StringLib
**Repository:** https://github.com/CMDred/StringLib
**License:** MIT

Bundled under the `stringlib` namespace. Exposed via `macroengine:core/lib/string/*`.

| Function | Description |
|---|---|
| `lib/string/concat` | Join a string array |
| `lib/string/find` | Find substring index |
| `lib/string/replace` | Replace substring |
| `lib/string/split` | Split by separator |
| `lib/string/insert` | Insert at index |
| `lib/string/to_lowercase` | Lowercase (A–Z, fast) |
| `lib/string/to_uppercase` | Uppercase (a–z, fast) |
| `lib/string/to_number` | String → numeric NBT |
| `lib/string/to_string` | Value → string |

All functions read from `macroengine:input` and write to `macroengine:output string.result`.

```mcfunction
data modify storage macroengine:input string set value "Hello World"
data modify storage macroengine:input find set value "World"
data modify storage macroengine:input replace set value "Everyone"
function macroengine:core/lib/string/replace
# macroengine:output string.result → "Hello Everyone"
```

## 💬 Support

**This project is archived. Issues and pull requests are not monitored and will not be actioned.**

[![Issues](https://img.shields.io/github/issues/runtoolkit/macroEngine?style=for-the-badge)](https://github.com/runtoolkit/macroEngine/issues)
[![Discussions](https://img.shields.io/github/discussions/runtoolkit/macroEngine?style=for-the-badge&logo=github&color=blue)](https://github.com/runtoolkit/macroEngine/discussions)

---

*MacroEngine v6.0.2 | MC Java 26.2 | Pure Datapack*
