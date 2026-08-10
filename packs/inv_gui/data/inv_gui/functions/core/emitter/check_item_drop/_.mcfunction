#> inv_gui:core/emitter/check_item_drop/_
#
# Fire item drop as event
#
# @within function inv_gui:core/tick

#>
# @within function inv_gui:core/emitter/check_item_drop/**
#declare tag inv_gui.checkItemDrop.this

# Search for dropped item
tag @s add inv_gui.checkItemDrop.this
execute as @e[type=minecraft:item, distance=..5.0] run function inv_gui:core/emitter/check_item_drop/find_dropped_item/_
tag @s remove inv_gui.checkItemDrop.this
