# inv_gui

**inv_gui** is a Minecraft Java Edition datapack library for building inventory-based GUI menus. It is a fully renamed and restructured fork of [Sketch](https://github.com/rarula/Sketch).

> Maintainer: [runtoolkit](https://github.com/runtoolkit)  
> Version: **1.0.0**  
> Minecraft: **1.20.2 – 1.20.4** (`pack_format 26`)  
> License: CC0-1.0  
> Note: **1.21+ support will be added via overlay system in future commits.**

---

## Features

- 27-slot GUI menus using Chest Minecart or Ender Chest
- Button, normal item, and variable item types
- Click & drop event detection
- Callback system (listener-based)
- Swap active menu mid-session with `set_menu`
- `util/map` and `util/array` helper modules

---

## Dependencies

The following datapacks must be loaded alongside inv_gui:data

| Datapack | License | Link |
|---|---|---|
| Oh! My Dat! | MIT | [Ai-Akaishi/OhMyDat](https://github.com/Ai-Akaishi/OhMyDat) |
| Close Detector | MIT | [Ai-Akaishi/CloseDetector](https://github.com/Ai-Akaishi/CloseDetector) |
| Player Item Tuner | MIT | [Ai-Akaishi/PlayerItemTuner](https://github.com/Ai-Akaishi/PlayerItemTuner) |

---

## Installation

```mcfunction
execute in minecraft:overworld run function inv_gui:api/setup
```

> Run once per dimension. See [docs/installation.md](docs/installation.md) for details.

---

## Quick Start

```mcfunction
# Register a filler button (key "f")
item replace block 10000 0 10000 container.0 with minecraft:gray_stained_glass_pane
data modify storage inv_gui:data in.key set value "f"
function inv_gui:api/register_item/button

# Register a clickable gold block (key "G", listener "give_gold")
item replace block 10000 0 10000 container.0 with minecraft:gold_block
data modify storage inv_gui:data in.key set value "G"
data modify storage inv_gui:data in.listener set value "give_gold"
function inv_gui:api/register_item/button

# Define the menu layout (3 rows x 9 columns)
data modify storage inv_gui:data in.contents append value [f, f, f, f, f, f, f, f, f]
data modify storage inv_gui:data in.contents append value [f, -, -, -, G, -, -, -, f]
data modify storage inv_gui:data in.contents append value [f, f, f, f, f, f, f, f, f]

data modify storage inv_gui:data in.id set value "main_menu"
function inv_gui:api/build/auto
```

Full API reference: [docs/api.md](docs/api.md)

---

## Storage Structure

```
inv_gui:data      Main input/output storage (API parameters)
  in.key          Short key of the item to register
  in.listener     Click listener name
  in.contents     Menu layout (3 rows × 9 columns)
  in.id           Menu identifier
  callback.*      Return data after a click event

inv_gui:core      Internal persistent data (CurrentMenuType etc.)
inv_gui:temp      Temporary operation data
inv_gui:util      Helper module data
```

---

## Scoreboards

| Objective | Type | Description |
|---|---|---|
| `InvGui` | dummy | General state score |
| `InvGui.Id` | dummy | Minecart menu ID index |
| `InvGui.Drop` | minecraft.used:carrot_on_a_stick | Drop detection |

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md)
