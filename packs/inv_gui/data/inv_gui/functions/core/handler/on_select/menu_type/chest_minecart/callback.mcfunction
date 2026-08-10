#> inv_gui:core/handler/on_select/menu_type/chest_minecart/callback
# @within function inv_gui:core/handler/on_select/menu_type/chest_minecart/_

## Set isInCallback
function inv_gui:core/common/is_in_callback/set


# Callback
data modify storage inv_gui:data callback.id set from storage inv_gui:temp MenuId
data modify storage inv_gui:data callback.listener set from storage inv_gui:temp Item.tag.inv_gui.listener
data modify storage inv_gui:data callback.selectedItem set from storage inv_gui:temp Item
data modify storage inv_gui:data callback.selectionType set from storage inv_gui:temp SelectionType
data modify storage inv_gui:data callback.otherItems set from storage inv_gui:temp CurrentContents
function #inv_gui:handler/on_select/chest_minecart

# Reset
data remove storage inv_gui:data callback


## Remove isInCallback
function inv_gui:core/common/is_in_callback/reset


# Build API was not called during callback -> Set current menu
execute unless data storage inv_gui:core {CalledBuildApi:true} run function inv_gui:core/handler/on_select/menu_type/chest_minecart/set_current_menu

# Reset
data remove storage inv_gui:core CalledBuildApi
