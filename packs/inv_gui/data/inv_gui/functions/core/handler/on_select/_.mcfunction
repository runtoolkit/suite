#> inv_gui:core/handler/on_select/_
#
# Called on selection
#
# @input
#   storage inv_gui:temp
#       SelectionType: "CLICK" | "DROP"
#           Type of selection
#
# @within function inv_gui:core/handler/*/_

## Set CalledOnSelect
data modify storage inv_gui:core CalledOnSelect set value true


# Processing for each type of opened chest
function #oh_my_dat:please
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui{CurrentMenuType:"Minecart"} at @s run function inv_gui:core/handler/on_select/menu_type/chest_minecart/_
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui{CurrentMenuType:"EnderChest"} at @s run function inv_gui:core/handler/on_select/menu_type/ender_chest/_

# Reset
data remove storage inv_gui:temp SelectionType


## Remove CalledOnSelect
data remove storage inv_gui:core CalledOnSelect
