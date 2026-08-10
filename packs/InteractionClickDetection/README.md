# Click Detection System

A lightweight, macro-free click detection system for Minecraft datapacks (1.20+).

Detects both **left-click** and **right-click** interactions on `minecraft:interaction` entities using vanilla advancements.

## Features

- ✅ **Left Click** detection (`player_hurt_entity`)
- ✅ **Right Click** detection (`player_interacted_with_entity`)
- ✅ No macros required
- ✅ Very lightweight (uses advancements + tag functions)
- ✅ Easy to integrate into other datapacks
- ✅ Works in multiplayer

## How to Use

### 1. Add the Datapack

Place the `click_detection` folder inside your datapack's `data/` directory.

### 2. Create Clickable Entities

When summoning an `interaction` entity, add the required tag:

```mcfunction
summon minecraft:interaction ~ ~ ~ {Tags:[".clickScan"], width:0.6f, height:0.6f}
```

> **Tip:** You can customize `width` and `height` to match your hitbox needs.

### 3. Listen for Clicks

Register your functions to receive click events:

#### For Left Click:
```json
// data/yourpack/tags/functions/on_lc.json
{
  "values": [
    "yourpack:clicked/left"
  ]
}
```

#### For Right Click:
```json
// data/yourpack/tags/functions/on_rc.json
{
  "values": [
    "yourpack:clicked/right"
  ]
}
```

### 4. Example Functions

**`data/yourpack/functions/clicked/left.mcfunction`**
```mcfunction
# Left click detected on an interaction entity

# Get the entity that was clicked
execute as @e[type=interaction,tag=.clickScan,sort=nearest,limit=1] run function yourpack:interaction/left_clicked

# Optional: visual feedback
particle minecraft:happy_villager ~ ~0.5 ~ 0.3 0.3 0.3 0 10
```

**`data/yourpack/functions/clicked/right.mcfunction`**
```mcfunction
# Right click detected
tellraw @s {"text":"You right-clicked the entity!","color":"gold"}
```

## Technical Details

The system works by:

1. Using two advancements (`lc.json` and `rc.json`) that trigger when a player interacts with any `interaction` entity tagged `.clickScan`.
2. Immediately revoking the advancement after triggering.
3. Calling the `#click_detection:on_lc` and `#click_detection:on_rc` tag functions.

## Compatibility

- **Minecraft Version**: 1.20 and above (pack_format 26)
- Works alongside other click detection methods
- No conflicts with most vanilla mechanics

## Credits

Created as a clean, reusable utility for the Minecraft datapack community.

---

**Happy datapacking!** ✨