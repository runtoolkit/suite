#> menu:main/listener
#
# Called when a player selects a button
#
# @within function menu_manager:handler/on_select

execute if data storage inv_gui:data callback{listener:"DimensionsMenu"} run function menu:dimensions/
execute if data storage inv_gui:data callback{listener:"DimensionsMenu"} run data modify storage inv_gui:data in.sound set value "minecraft:block.chest.open"
execute if data storage inv_gui:data callback{listener:"DimensionsMenu"} run function inv_gui:api/sound