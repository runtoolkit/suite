#> inv_gui:core/handler/on_container_close/ender_chest
#
# Called when an ender chest is closed
#
# @within function inv_gui:core/emitter/check_container_close/ender_chest

## Set isInCallback
function inv_gui:core/common/is_in_callback/set


# Set callback return value
data modify storage inv_gui:temp CurrentContents set from entity @s EnderItems
data remove storage inv_gui:temp CurrentContents[{tag:{inv_gui:{isButton:true}}}]

# Callback
data modify storage inv_gui:data callback.otherItems set from storage inv_gui:temp CurrentContents
function #inv_gui:handler/on_close/ender_chest

# Reset
data remove storage inv_gui:data callback
data remove storage inv_gui:temp CurrentContents


## Remove isInCallback
function inv_gui:core/common/is_in_callback/reset


# Remove menu info from OhMyDat
function #oh_my_dat:please
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui.MenuId
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui.Contents
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui.CurrentMenuType
