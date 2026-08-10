#> menu_manager:handler/on_select
#
# Called when a player selects a button
#
# @within tag/function inv_gui:handler/on_select/*

execute if data storage inv_gui:data callback{id:"main"} run function menu:main/listener
execute if data storage inv_gui:data callback{id:"dimensions"} run function menu:dimensions/listener
