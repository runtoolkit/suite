#> inv_gui:core/tick
#
# Called on tick
#
# @within tag/function minecraft:tick

# Check item click
execute as @a run function inv_gui:core/emitter/check_item_click/_

# Check item drop
execute if entity @a[scores={inv_gui.Drop=1..}, limit=1] as @a[scores={inv_gui.Drop=1..}] at @s if entity @e[type=minecraft:item, distance=..5.0, limit=1] run function inv_gui:core/emitter/check_item_drop/_

# Reset
scoreboard players reset @a[scores={inv_gui.Drop=-2147483648..2147483647}] inv_gui.Drop
