# inv_gui — User Guide

## Table of Contents

1. [Concepts](#1-concepts)
2. [Project Structure](#2-project-structure)
3. [Setup](#3-setup)
4. [Item Registration](#4-item-registration)
   - [button](#41-button)
   - [normal](#42-normal)
   - [variable](#43-variable)
   - [Global vs Local](#44-global-vs-local)
5. [Building a Menu](#5-building-a-menu)
   - [build/auto](#51-buildauto)
   - [build/chest_minecart & ender_chest](#52-buildchest_minecart--ender_chest)
   - [Layout Helpers](#53-layout-helpers)
6. [Handling Clicks](#6-handling-clicks)
   - [callback storage](#61-callback-storage)
   - [on_select hook](#62-on_select-hook)
7. [Navigation: set_menu](#7-navigation-set_menu)
8. [Variable Items](#8-variable-items)
   - [set_variable hook](#81-set_variable-hook)
9. [Open / Close Hooks](#9-open--close-hooks)
10. [Pagination](#10-pagination)
11. [UI Feedback](#11-ui-feedback)
    - [sound](#111-sound)
    - [title](#112-title)
    - [actionbar](#113-actionbar)
12. [Utility API](#12-utility-api)
    - [map](#121-map)
    - [array](#122-array)
13. [Registering a Chest Minecart](#13-registering-a-chest-minecart)
14. [Recommended Datapack Layout](#14-recommended-datapack-layout)
15. [Full Wiring Example](#15-full-wiring-example)
16. [Common Mistakes](#16-common-mistakes)

---

## 1. Concepts

inv_gui renders menus by placing items inside a **Chest Minecart** or **Ender Chest** at a fixed coordinate (`10000 0-2 10000`). The player opens that container and inv_gui listens to slot-change events to detect button clicks.

Three shulker boxes act as internal working buffers:

| Coordinate | Purpose |
|---|---|
| `10000 0 10000` | I/O container — item staging area |
| `10000 1 10000` | Item registry — stores registered items |
| `10000 2 10000` | Menu builder — assembles the final menu |

You never touch these coordinates directly. All interaction goes through the API functions documented below.

**Flow:**
```
register items -> build menu -> player clicks -> on_select fires -> listener handles it
```

---

## 2. Project Structure

A typical project using inv_gui has two namespaces:

```
data/
  menu_manager/        <- wires inv_gui events to your menus
    functions/
      init.mcfunction  <- runs on load: setup + register global items
      handler/
        on_open.mcfunction
        on_close.mcfunction
        on_select.mcfunction
      callback/
        set_menu.mcfunction
        set_variable.mcfunction

  menu/                <- your actual menus
    functions/
      main/
        .mcfunction    <- builds the main menu
        listener.mcfunction
      shop/
        .mcfunction
        listener.mcfunction
        variable.mcfunction
```

The `Example/` folder in this repo is a working reference for this pattern.

---

## 3. Setup

Run once per dimension where menus will appear, inside that dimension:

```mcfunction
execute in minecraft:overworld run function inv_gui:api/setup
execute in minecraft:the_nether run function inv_gui:api/setup
execute in minecraft:the_end run function inv_gui:api/setup
```

Call this from your `init.mcfunction` (hooked into `#minecraft:load`).

`setup` places the three shulker boxes and forceloads the chunk. Without it, no menu can be built in that dimension.

---

## 4. Item Registration

All items must be registered before they can be placed in a menu layout. Registration stores the item (and its metadata) in the internal registry shulker box.

### 4.1 button

A clickable item. When selected, fires the `on_select` event with `callback.listener` set to the registered value.

```mcfunction
# Place the item in the I/O container slot 0
item replace block 10000 0 10000 container.0 with minecraft:diamond

# Set the key (used in the layout string)
data modify storage inv_gui:data in.key set value "D"

# Set the listener name (read from callback.listener in on_select)
data modify storage inv_gui:data in.listener set value "give_diamond"

function inv_gui:api/register_item/button
```

The `listener` field can be any NBT value — a string, a compound, or even a number. Using a compound lets you embed extra data:

```mcfunction
data modify storage inv_gui:data in.listener set value {action:"tp",world:"overworld"}
```

Then check it in your listener:

```mcfunction
execute if data storage inv_gui:data callback{listener:{action:"tp",world:"overworld"}} run ...
```

### 4.2 normal

A display-only item — it appears in the menu but clicks do nothing.

```mcfunction
item replace block 10000 0 10000 container.0 with minecraft:gray_stained_glass_pane{display:{Name:'""'}}
data modify storage inv_gui:data in.key set value "f"
function inv_gui:api/register_item/normal
```

### 4.3 variable

A placeholder slot whose item is determined dynamically at render time (see [section 8](#8-variable-items)). You do not place an item in the I/O container for variable registration — only the key is needed.

```mcfunction
data modify storage inv_gui:data in.key set value "V"
function inv_gui:api/register_item/variable
```

### 4.4 Global vs Local

All three item types support an optional `isGlobal` flag:

| Scope | Flag | Visibility |
|---|---|---|
| Local (default) | `false` | Only accessible within the current dimension |
| Global | `true` | Accessible from all dimensions |

```mcfunction
data modify storage inv_gui:data in.isGlobal set value true
function inv_gui:api/register_item/button
```

Register global items in `init.mcfunction` at load time so they are available in every dimension from the start.

To remove a global item:

```mcfunction
data modify storage inv_gui:data in.key set value "D"
function inv_gui:api/unregister_item
```

---

## 5. Building a Menu

After registering items, build the menu with a layout string and an ID.

### 5.1 build/auto

Detects the container type (Chest Minecart or Ender Chest) automatically.

```mcfunction
# in.id: any value — used to route callbacks
data modify storage inv_gui:data in.id set value "main"

# in.contents: 3 rows, each a list of exactly 9 item keys
# "-" means empty slot; any other string must match a registered key
data modify storage inv_gui:data in.contents append value ["f","f","f","f","f","f","f","f","f"]
data modify storage inv_gui:data in.contents append value ["f","-","-","-","D","-","-","-","f"]
data modify storage inv_gui:data in.contents append value ["f","f","f","f","f","f","f","f","f"]

function inv_gui:api/build/auto
```

> `build/auto` must be called as the executing player (`@s`), not from a console command.

### 5.2 build/chest_minecart & ender_chest

Same input format as `build/auto` but targets a specific container type regardless of what is open.

```mcfunction
function inv_gui:api/build/chest_minecart
function inv_gui:api/build/ender_chest
```

### 5.3 Layout Helpers

These helpers append rows to `in.contents` so you do not have to write them by hand.

#### fill_border

Appends a 3-row bordered layout (useful as a starting base):

```
Row 0: [key][key][key][key][key][key][key][key][key]
Row 1: [key][ - ][ - ][ - ][ - ][ - ][ - ][ - ][key]
Row 2: [key][key][key][key][key][key][key][key][key]
```

```mcfunction
data modify storage inv_gui:data in.key set value "f"
function inv_gui:api/fill_border
# Then set in.id and call build/auto
```

#### fill_row

Appends one full 9-slot row:

```mcfunction
data modify storage inv_gui:data in.key set value "f"
function inv_gui:api/fill_row
```

Use `"-"` as the key for an empty row.

#### fill_checker

Appends a 3-row checkerboard pattern with two alternating keys:

```
Row 0: [a][b][a][b][a][b][a][b][a]
Row 1: [b][a][b][a][b][a][b][a][b]
Row 2: [a][b][a][b][a][b][a][b][a]
```

```mcfunction
data modify storage inv_gui:data in.key_a set value "W"
data modify storage inv_gui:data in.key_b set value "f"
function inv_gui:api/fill_checker
```

---

## 6. Handling Clicks

### 6.1 callback storage

When a player clicks a registered button, inv_gui writes to `inv_gui:data callback`:

```
inv_gui:data callback
  .id            -> menu identifier (matches in.id from build)
  .listener      -> listener value from the clicked item's registration
  .selectedItem  -> full item NBT of the clicked item
  .selectionType -> "CLICK" or "DROP"
  .slot          -> slot index as a byte (e.g. 10b = slot 10)
  .otherItems    -> snapshot of all other items in the menu at click time
```

### 6.2 on_select hook

Add your handler function to the appropriate tag:

```json
{ "values": ["your_ns:handler/on_select"] }
```

File path: `data/inv_gui/tags/functions/handler/on_select/chest_minecart.json`

Your handler reads `callback` and dispatches:

```mcfunction
#> your_ns:handler/on_select

# Route by menu id, then handle inside the listener
execute if data storage inv_gui:data callback{id:"main"} run function menu:main/listener
execute if data storage inv_gui:data callback{id:"shop"} run function menu:shop/listener
```

Inside a listener function:

```mcfunction
#> menu:main/listener

execute if data storage inv_gui:data callback{listener:"open_shop"} run function menu:shop/
execute if data storage inv_gui:data callback{listener:"close"} run tellraw @s "Bye!"
```

> **Note:** The Build API (`build/auto`, `set_menu`, etc.) can be called freely inside a listener to switch menus mid-session.

---

## 7. Navigation: set_menu

`set_menu` rebuilds the open menu with a different configuration without closing it. Ideal for sub-menu navigation.

```mcfunction
data modify storage inv_gui:data in.id set value "settings"
function inv_gui:api/set_menu
```

inv_gui then fires the `#inv_gui:set_menu/<type>` tag. Hook into it to rebuild:

File path: `data/inv_gui/tags/functions/set_menu/chest_minecart.json`

```json
{ "values": ["menu_manager:callback/set_menu"] }
```

```mcfunction
#> menu_manager:callback/set_menu

execute if data storage inv_gui:data callback{id:"main"} run function menu:main/
execute if data storage inv_gui:data callback{id:"settings"} run function menu:settings/
execute if data storage inv_gui:data callback{id:"shop"} run function menu:shop/
```

Using `set_menu` from a listener — just call the build function directly:

```mcfunction
execute if data storage inv_gui:data callback{listener:"go_settings"} run function menu:settings/
```

Calling a build function inside a callback automatically triggers `set_menu` routing. You do not need to call `set_menu` explicitly.

---

## 8. Variable Items

Variable items let you display different items in the same slot depending on runtime state (toggles, player data, counters, etc.).

### 8.1 set_variable hook

When the menu is being rendered, inv_gui fires `#inv_gui:set_variable/<type>` for each variable slot. Add your handler:

File path: `data/inv_gui/tags/functions/set_variable/chest_minecart.json`

```json
{ "values": ["menu_manager:callback/set_variable"] }
```

```mcfunction
#> menu_manager:callback/set_variable

execute if data storage inv_gui:data callback{id:"settings"} run function menu:settings/variable
```

Inside the variable function, check `callback.slot` to identify which slot is being rendered:

```mcfunction
#> menu:settings/variable

# Slot 10 — glow toggle (ON state)
execute if data storage inv_gui:data callback{slot:10b} if data storage myns:state {Glow:true} run item replace block 10000 0 10000 container.0 with minecraft:spectral_arrow{display:{Name:'{"text":"Glow: ON","color":"green"}'}}
execute if data storage inv_gui:data callback{slot:10b} if data storage myns:state {Glow:true} run data modify storage inv_gui:data in.listener set value "GlowOn"

# Slot 10 — glow toggle (OFF state)
execute if data storage inv_gui:data callback{slot:10b} unless data storage myns:state {Glow:true} run item replace block 10000 0 10000 container.0 with minecraft:arrow{display:{Name:'{"text":"Glow: OFF","color":"red"}'}}
execute if data storage inv_gui:data callback{slot:10b} unless data storage myns:state {Glow:true} run data modify storage inv_gui:data in.listener set value "GlowOff"

# Apply the item modifier to finalise the slot — required for every variable slot
execute if data storage inv_gui:data callback{slot:10b} run item modify block 10000 0 10000 container.0 inv_gui:register_item/button
```

> Always end each variable slot block with `item modify ... inv_gui:register_item/button` (or `/normal`). Without it the slot is silently skipped.

**Slot index reference** for a 3x9 menu:

```
Row 0:  0  1  2  3  4  5  6  7  8
Row 1:  9 10 11 12 13 14 15 16 17
Row 2: 18 19 20 21 22 23 24 25 26
```

---

## 9. Open / Close Hooks

React when a player opens or closes a managed container.

File path: `data/inv_gui/tags/functions/handler/on_open/chest_minecart.json`

```json
{ "values": ["menu_manager:handler/on_open"] }
```

```mcfunction
#> menu_manager:handler/on_open
# Called as the player who opened the container (@s = player)

function menu:main/
```

```mcfunction
#> menu_manager:handler/on_close
# Called as the player who closed the container

data remove storage myns:state PlayerMenuData
```

All four hooks:

| Tag file | Fires when |
|---|---|
| `handler/on_open/chest_minecart.json` | Chest Minecart opened |
| `handler/on_open/ender_chest.json` | Ender Chest opened |
| `handler/on_close/chest_minecart.json` | Chest Minecart closed |
| `handler/on_close/ender_chest.json` | Ender Chest closed |

---

## 10. Pagination

For menus with more items than fit on one page, use `paginate` + `page_controls`.

```mcfunction
# Full list of registered item keys
data modify storage inv_gui:data in.items set value ["I1","I2","I3","I4","I5","I6","I7","I8","I9","I10"]

# Current page (0-indexed) — read from your own state storage
data modify storage inv_gui:data in.page set from storage myns:state Page

# Items per page (optional, default: 7)
data modify storage inv_gui:data in.size set value 7

function inv_gui:api/paginate
# Output written to inv_gui:data out:
#   out.items    -> item keys for this page
#   out.has_prev -> 1b if previous page exists, 0b otherwise
#   out.has_next -> 1b if next page exists, 0b otherwise
```

Then append a navigation row with `page_controls`:

```mcfunction
data modify storage inv_gui:data in.prev_key set value "PREV"
data modify storage inv_gui:data in.next_key set value "NEXT"
data modify storage inv_gui:data in.filler_key set value "f"
data modify storage inv_gui:data in.has_prev set from storage inv_gui:data out.has_prev
data modify storage inv_gui:data in.has_next set from storage inv_gui:data out.has_next
function inv_gui:api/page_controls
# Appends one 9-slot navigation row to in.contents
```

Handle PREV / NEXT clicks in your listener:

```mcfunction
execute if data storage inv_gui:data callback{listener:"PREV"} run scoreboard players remove @s myns.ShopPage 1
execute if data storage inv_gui:data callback{listener:"NEXT"} run scoreboard players add @s myns.ShopPage 1
execute if data storage inv_gui:data callback{listener:"PREV"} run function menu:shop/
execute if data storage inv_gui:data callback{listener:"NEXT"} run function menu:shop/
```

---

## 11. UI Feedback

### 11.1 sound

Play a sound to the executing player:

```mcfunction
data modify storage inv_gui:data in.sound set value "minecraft:ui.button.click"
data modify storage inv_gui:data in.source set value "master"
data modify storage inv_gui:data in.volume set value 1.0f
data modify storage inv_gui:data in.pitch set value 1.0f
function inv_gui:api/sound
```

All fields except `sound` are optional (defaults shown above).

Common sounds:

| Sound | Use case |
|---|---|
| `minecraft:ui.button.click` | Standard UI click |
| `minecraft:block.note_block.pling` | Success / positive |
| `minecraft:entity.villager.no` | Reject / denied |
| `minecraft:item.book.page_turn` | Page turn |
| `minecraft:entity.experience_orb.pickup` | Reward / confirm |

### 11.2 title

Show a title and optional subtitle:

```mcfunction
data modify storage inv_gui:data in.title set value "Kit Selected!"
data modify storage inv_gui:data in.subtitle set value "Warrior kit given."
data modify storage inv_gui:data in.fade_in set value 5
data modify storage inv_gui:data in.stay set value 40
data modify storage inv_gui:data in.fade_out set value 10
function inv_gui:api/title
```

> Title and subtitle text must not contain double-quote (`"`) characters.

### 11.3 actionbar

Show a short message in the action bar:

```mcfunction
data modify storage inv_gui:data in.text set value "Teleporting..."
data modify storage inv_gui:data in.color set value "green"
function inv_gui:api/actionbar
```

Valid colors: `white`, `yellow`, `gold`, `red`, `green`, `dark_green`, `aqua`, `dark_aqua`, `blue`, `light_purple`, `gray`, `dark_gray`.

---

## 12. Utility API

These functions are internal helpers but are also available for use in your own datapacks.

### 12.1 map

A key-value data structure backed by NBT storage.

```mcfunction
# set — add or update a key
data modify storage inv_gui:util in.key set value "myKey"
data modify storage inv_gui:util in.value set value "hello"
# optionally pass an existing map to update:
# data modify storage inv_gui:util in.map set from storage myns:state MyMap
function inv_gui:util/map/set
# result -> inv_gui:util out.map
```

```mcfunction
# get — retrieve a value by key
data modify storage inv_gui:util in.key set value "myKey"
data modify storage inv_gui:util in.map set from storage myns:state MyMap
function inv_gui:util/map/get
# result -> inv_gui:util out.value, out.contains (boolean)
```

```mcfunction
# has — check if a key exists
data modify storage inv_gui:util in.key set value "myKey"
data modify storage inv_gui:util in.map set from storage myns:state MyMap
function inv_gui:util/map/has
# result -> inv_gui:util out.contains (boolean)
```

```mcfunction
# delete — remove a key
data modify storage inv_gui:util in.key set value "myKey"
data modify storage inv_gui:util in.map set from storage myns:state MyMap
function inv_gui:util/map/delete
# result -> inv_gui:util out.map
```

### 12.2 array

```mcfunction
# flat — recursively flatten a nested array
data modify storage inv_gui:util in.array set value [[1,2],[3,[4,5]]]
function inv_gui:util/array/flat
# result -> inv_gui:util out.array = [1,2,3,4,5]
```

```mcfunction
# reverse — reverse element order
data modify storage inv_gui:util in.array set value [1,2,3,4]
function inv_gui:util/array/reverse
# result -> inv_gui:util out.array = [4,3,2,1]
```

```mcfunction
# slice — extract a sub-array (start inclusive, end exclusive)
data modify storage inv_gui:util in.array set value ["a","b","c","d","e"]
data modify storage inv_gui:util in.start set value 1
data modify storage inv_gui:util in.end set value 3
function inv_gui:util/array/slice
# result -> inv_gui:util out.array = ["b","c","d"]
```

---

## 13. Registering a Chest Minecart

By default inv_gui uses a pre-placed Chest Minecart. To register one dynamically (e.g. a custom NPC cart):

```mcfunction
# Run as the Chest Minecart entity
execute as <minecart_entity> run function inv_gui:api/register_chest_minecart
```

This assigns a unique `InvGui.Id` score to the entity so inv_gui can track which cart belongs to which player.

---

## 14. Recommended Datapack Layout

```
data/
  inv_gui/                       <- inv_gui itself (do not edit)

  menu_manager/
    functions/
      init.mcfunction            <- load hook: setup + register global items
      handler/
        on_open.mcfunction       <- open the default menu
        on_close.mcfunction      <- cleanup on close
        on_select.mcfunction     <- route to menu listeners by id
      callback/
        set_menu.mcfunction      <- route set_menu rebuilds by id
        set_variable.mcfunction  <- route variable slot renders by id

  inv_gui/
    tags/functions/
      handler/on_open/chest_minecart.json    -> ["menu_manager:handler/on_open"]
      handler/on_close/chest_minecart.json   -> ["menu_manager:handler/on_close"]
      handler/on_select/chest_minecart.json  -> ["menu_manager:handler/on_select"]
      set_menu/chest_minecart.json           -> ["menu_manager:callback/set_menu"]
      set_variable/chest_minecart.json       -> ["menu_manager:callback/set_variable"]

  minecraft/
    tags/functions/
      load.json                  -> ["menu_manager:init"]

  menu/
    functions/
      main/
        .mcfunction              <- builds the main menu
        listener.mcfunction      <- handles clicks
      shop/
        .mcfunction
        listener.mcfunction
        variable.mcfunction      <- dynamic slot rendering
```

---

## 15. Full Wiring Example

### init.mcfunction

```mcfunction
#> menu_manager:init

# Setup in all dimensions where menus will appear
execute in minecraft:overworld run function inv_gui:api/setup
execute in minecraft:the_nether run function inv_gui:api/setup
execute in minecraft:the_end run function inv_gui:api/setup

# Register global empty slot (accessible everywhere)
item replace block 10000 0 10000 container.0 with minecraft:air
data modify storage inv_gui:data in.key set value "-"
data modify storage inv_gui:data in.isGlobal set value true
function inv_gui:api/register_item/normal

# Register global filler (gray glass pane)
item replace block 10000 0 10000 container.0 with minecraft:gray_stained_glass_pane{display:{Name:'""'}}
data modify storage inv_gui:data in.key set value "f"
data modify storage inv_gui:data in.isGlobal set value true
function inv_gui:api/register_item/normal
```

### handler/on_open.mcfunction

```mcfunction
#> menu_manager:handler/on_open

function menu:main/
```

### handler/on_select.mcfunction

```mcfunction
#> menu_manager:handler/on_select

execute if data storage inv_gui:data callback{id:"main"} run function menu:main/listener
execute if data storage inv_gui:data callback{id:"shop"} run function menu:shop/listener
```

### callback/set_menu.mcfunction

```mcfunction
#> menu_manager:callback/set_menu

execute if data storage inv_gui:data callback{id:"main"} run function menu:main/
execute if data storage inv_gui:data callback{id:"shop"} run function menu:shop/
```

### menu/main/.mcfunction

```mcfunction
#> menu:main/

# Filler
item replace block 10000 0 10000 container.0 with minecraft:gray_stained_glass_pane{display:{Name:'""'}}
data modify storage inv_gui:data in.key set value "f"
function inv_gui:api/register_item/normal

# Shop button
item replace block 10000 0 10000 container.0 with minecraft:emerald{display:{Name:'{"text":"Shop","color":"green","bold":true}'}}
data modify storage inv_gui:data in.key set value "S"
data modify storage inv_gui:data in.listener set value "OpenShop"
function inv_gui:api/register_item/button

# Build layout
data modify storage inv_gui:data in.contents append value ["f","f","f","f","f","f","f","f","f"]
data modify storage inv_gui:data in.contents append value ["f","-","-","-","S","-","-","-","f"]
data modify storage inv_gui:data in.contents append value ["f","f","f","f","f","f","f","f","f"]
data modify storage inv_gui:data in.id set value "main"
function inv_gui:api/build/auto
```

### menu/main/listener.mcfunction

```mcfunction
#> menu:main/listener

# Click sound on every interaction
data modify storage inv_gui:data in.sound set value "minecraft:ui.button.click"
function inv_gui:api/sound

# Navigate to shop
execute if data storage inv_gui:data callback{listener:"OpenShop"} run function menu:shop/
```

---

## 16. Common Mistakes

| Mistake | Fix |
|---|---|
| Calling `build/auto` from console (not as a player) | Always run via `execute as <player> run function ...` |
| Forgetting `inv_gui:api/setup` in a dimension | Run setup inside every dimension where menus appear |
| Using `function inv_gui:api/setup` without `execute in` | Use `execute in minecraft:overworld run function inv_gui:api/setup` |
| Layout row has wrong count (not 9 keys) | Every row must be exactly 9 keys: `["a","b","c","d","e","f","g","h","i"]` |
| Using a key in the layout that was never registered | Every non-`"-"` key in `in.contents` must be registered before `build/auto` |
| Variable slot missing `item modify ... inv_gui:register_item/button` | Without this the slot is silently skipped |
| `callback.listener` is a compound but matched as a string | Use `callback{listener:{id:"X"}}` not `callback{listener:"X"}` |
| Registering items inside a listener without rebuilding | Register items before calling the build function |
| `in.contents` leftover from a previous build | `build/auto` consumes `in.contents`; stale rows from a previous call will be included |
