#> inv_gui:core/handler/on_container_open/chest_minecart/_
#
# Called when a chest minecart is opened
#
# @within function inv_gui:core/emitter/check_container_open/chest_minecart

# Set opened chest type in OhMyDat
function #oh_my_dat:please
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].inv_gui.CurrentMenuType set value "Minecart"


## Set isInCallback
function inv_gui:core/common/is_in_callback/set

## Search for opened chest minecart
function inv_gui:core/handler/on_container_open/chest_minecart/filter/find


# Callback
function #inv_gui:handler/on_open/chest_minecart


## Remove inv_gui.Target
function inv_gui:core/common/inv_gui_target/reset

## Remove isInCallback
function inv_gui:core/common/is_in_callback/reset
