#> inv_gui:core/api/set_menu/ender_chest
# @within function inv_gui:core/api/set_menu/_

## Set isInCallback
function inv_gui:core/common/is_in_callback/set


# Callback
data modify storage inv_gui:data callback.id set from storage inv_gui:data in.id
data remove storage inv_gui:data in
execute at @s run function #inv_gui:set_menu/ender_chest

# Reset
data remove storage inv_gui:data callback


## Remove isInCallback
function inv_gui:core/common/is_in_callback/reset
