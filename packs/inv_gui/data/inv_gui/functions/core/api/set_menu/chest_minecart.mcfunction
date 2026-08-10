#> inv_gui:core/api/set_menu/chest_minecart
# @within function inv_gui:core/api/set_menu/_

## Set isInCallback
function inv_gui:core/common/is_in_callback/set

## Set inv_gui.Target
function inv_gui:core/common/inv_gui_target/set


# Callback
data modify storage inv_gui:data callback.id set from storage inv_gui:data in.id
data remove storage inv_gui:data in
execute at @s run function #inv_gui:set_menu/chest_minecart

# Reset
data remove storage inv_gui:data callback


## Remove inv_gui.Target
function inv_gui:core/common/inv_gui_target/reset

## Remove isInCallback
function inv_gui:core/common/is_in_callback/reset
