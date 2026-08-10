#> inv_gui:core/emitter/check_item_click/_
#
# Fire item click as event
#
# @within function inv_gui:core/tick
#
# Note: Using @s inv_gui score instead of storage (per-tick, per-player speedup)

# Check item click (save result to score)
execute store success score @s inv_gui run clear @s #inv_gui:all{inv_gui:{isButton:true}}

# Item is being clicked -> Fire event
execute if score @s inv_gui matches 1 run function inv_gui:core/handler/on_item_click/_

# Reset
scoreboard players reset @s inv_gui
