#> inv_gui:core/common/api/build/create_menu/set_item/item_type/variable/ender_chest
# @within function inv_gui:core/common/api/build/create_menu/set_item/item_type/variable/_

## Set inv_gui.Player
tag @s add inv_gui.Player


# Callback
execute at @s run function #inv_gui:set_variable/ender_chest


## Remove inv_gui.Player
function inv_gui:core/common/inv_gui_player/reset
