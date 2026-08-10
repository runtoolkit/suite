#> inv_gui:core/handler/on_select/menu_type/ender_chest/set_current_menu
# @within function inv_gui:core/handler/on_select/menu_type/ender_chest/callback

## Set isInCallback
function inv_gui:core/common/is_in_callback/set


# Callback
data modify storage inv_gui:data callback.id set from storage inv_gui:temp MenuId
function #inv_gui:set_menu/ender_chest

# Reset
data remove storage inv_gui:data callback


## Remove isInCallback
function inv_gui:core/common/is_in_callback/reset
