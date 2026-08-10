#> menu_manager:init
# @within tag/function minecraft:load

# setup
execute in minecraft:overworld run function inv_gui:api/setup
execute in minecraft:the_nether run function inv_gui:api/setup
execute in minecraft:the_end run function inv_gui:api/setup

# Register an item
item replace block 10000 0 10000 container.0 with minecraft:air
data modify storage inv_gui:data in.key set value "-"
data modify storage inv_gui:data in.isGlobal set value true
function inv_gui:api/register_item/normal
