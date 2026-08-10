#> inv_gui:core/api/set_menu/_
#
# @input
#   storage inv_gui:data in
#       id: any
#
# @within function inv_gui:api/set_menu

## pre
function inv_gui:core/common/api/set_menu/pre


# Processing for each type of opened chest
function #oh_my_dat:please
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui{CurrentMenuType:"Minecart"} run function inv_gui:core/api/set_menu/chest_minecart
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui{CurrentMenuType:"EnderChest"} run function inv_gui:core/api/set_menu/ender_chest

# Reset
data remove storage inv_gui:data in


## post
function inv_gui:core/common/api/set_menu/post
