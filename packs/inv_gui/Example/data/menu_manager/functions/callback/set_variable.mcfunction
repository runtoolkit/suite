#> menu_manager:callback/set_variable
#
# Called when placing a temporary item
#
# @within tag/function inv_gui:set_variable/*

execute if data storage inv_gui:data callback{id:"dimensions"} run function menu:dimensions/variable
