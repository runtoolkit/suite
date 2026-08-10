#> menu_manager:callback/set_menu
#
# Called when the menu is reconfigured
#
# @within tag/function inv_gui:set_menu/*

execute if data storage inv_gui:data callback{id:"main"} run function menu:main/
execute if data storage inv_gui:data callback{id:"dimensions"} run function menu:dimensions/
