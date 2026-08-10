#> inv_gui:core/handler/on_container_close/chest_minecart
#
# Called when a chest minecart is closed
#
# @within function inv_gui:core/emitter/check_container_close/chest_minecart

## Set isInCallback
function inv_gui:core/common/is_in_callback/set

## Set inv_gui.Target
function inv_gui:core/common/inv_gui_target/set


# Set callback return value
data modify storage inv_gui:temp CurrentContents set from entity @e[type=minecraft:chest_minecart, tag=inv_gui.Target, limit=1] Items
data remove storage inv_gui:temp CurrentContents[{tag:{inv_gui:{isButton:true}}}]

# Callback
data modify storage inv_gui:data callback.otherItems set from storage inv_gui:temp CurrentContents
function #inv_gui:handler/on_close/chest_minecart

# Reset
data remove storage inv_gui:data callback
data remove storage inv_gui:temp CurrentContents


## Remove inv_gui.Target
function inv_gui:core/common/inv_gui_target/reset

## Remove isInCallback
function inv_gui:core/common/is_in_callback/reset


# Remove menu info from OhMyDat
function #oh_my_dat:please
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui.CurrentMenuType

# Remove inv_gui.Id
scoreboard players reset @s inv_gui.Id
