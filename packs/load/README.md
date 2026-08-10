# RunLoad

> **⚠️ Fork Notice**
> This project is a fork and continuation of [LanternMC/load](https://github.com/LanternMC/load), maintained independently under the [runtoolkit](https://github.com/runtoolkit) organisation.
> It is **not affiliated with** the original Lantern Load project or its authors.
> All original code is used under the terms of the [0BSD License](LICENSE).

---

RunLoad provides a lightweight, reliable implementation of load-order resolution for Minecraft datapacks.
It allows datapacks and their dependencies to initialise in a deterministic, controllable sequence — all within the same tick as `/reload`.

**Requires Minecraft 1.21 or higher** (`pack_format 48+`).

---

## How It Works

On every `/reload`, `#minecraft:load` triggers `#load:_private/load`, which runs the following pipeline in order:

```
#load:_private/init   →   reset load.status scores + reload-flag logic
  └─ #load:reload     →   (optional) fires only on manual /reload, not on first world load
#load:pre_load        →   (optional) run before main load
#load:load            →   (optional) main load phase — register your pack here
#load:post_load       →   (optional) run after main load
```

The `load.status` scoreboard is reset at the start of every reload so each pack always reports a fresh, accurate status.

RunLoad itself registers `scoreboard players set RunLoad load.status 1` on every load — other packs can check this score to confirm RunLoad is present.

---

## Installation

Copy the `load` and `minecraft` directories from `data/` into your pack's `data/` folder.
After copying, your `minecraft/tags/function/load.json` must call `#load:_private/load`.

---

## Usage

### Registering your pack

Add your load function to `data/load/tags/function/load.json`:

```json
{
    "values": [
        "your_pack:load"
    ]
}
```

Use `pre_load.json` or `post_load.json` if you need to run before or after other packs.

---

### Pack versioning with `load.status`

Each pack **should** define at least one fake player whose name includes the pack name, and set its `load.status` score on load.
This score **must not decrease** in future updates; it may stay constant or increment.

```mcfunction
# your_pack:load
scoreboard players set your_pack load.status 1
schedule function your_pack:tick 1t
```

Other packs can then check your score to detect whether your pack is present.

---

### Avoiding `#minecraft:tick`

`#minecraft:tick` runs **before** `#minecraft:load`, meaning your pack can be ticked before it has been initialised.
The recommended pattern is to schedule your tick from your load function instead:

```mcfunction
# your_pack:load
scoreboard players set your_pack load.status 1
schedule function your_pack:tick 1t

# your_pack:tick
# ... your tick logic ...
schedule function your_pack:tick 1t
```

---

### Checking for dependencies

```mcfunction
# your_pack:load
schedule clear your_pack:tick
execute if score dep_pack load.status matches 1.. run scoreboard players set your_pack load.status 1
execute if score your_pack load.status matches 1  run function your_pack:init

# your_pack:init
scoreboard objectives add your_objective dummy
schedule function your_pack:tick 1t
```

---

## `#load:reload` — Manual Reload Detection

`#load:reload` fires **only on manual `/reload`**, not on the first ever world load.
This lets packs run cleanup or re-init logic that should not run during initial startup.

```json
// data/load/tags/function/reload.json
{
    "values": [
        "your_pack:on_reload"
    ]
}
```

```mcfunction
# your_pack:on_reload
# Runs only when the server operator types /reload — safe to put teardown logic here.
schedule clear your_pack:tick
scoreboard players reset your_pack load.status
```

---

## `load:api/require` — Dependency Checking (Macro, 1.20.2+)

A macro-based utility that checks whether a dependency pack has a `load.status` score meeting a minimum version threshold.

**Input** — write to `storage load:input` before calling:

| Key | Type | Description |
|---|---|---|
| `pack` | string | Fake player name to check |
| `min` | int | Minimum acceptable score (e.g. `1`) |

**Output** — read from `storage load:output` after calling:

| Key | Type | Description |
|---|---|---|
| `require.success` | `1b` / `0b` | Whether the check passed |

**Example:**

```mcfunction
# your_pack:load
data modify storage load:input pack set value "dep_pack"
data modify storage load:input min  set value 1
function load:api/require
execute if data storage load:output {require:{success:1b}} run function your_pack:init
execute unless data storage load:output {require:{success:1b}} run tellraw @a "your_pack: missing dep_pack!"
```

---

## Compatibility

| Minecraft version | pack_format | Supported |
|---|---|---|
| 1.21 – 1.21.1 | 48 – 57 | ✅ |
| 1.21.2 – 1.21.3 | 57 | ✅ |
| 1.21.4 | 61 | ✅ |
| 1.21.5 | 71 | ✅ |
| 1.21.6+ | 71+ | ✅ (auto via `supported_formats`) |
| 1.20.6 or older | — | ❌ |

---

## License

Released under the [0BSD License](LICENSE). You may use, copy, modify, and distribute this freely with no conditions.
Third-party contributions are licensed under the same terms unless explicitly stated otherwise.
