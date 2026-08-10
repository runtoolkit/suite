#> inv_gui:core/common/api/build/create_menu/set_item/item_type/variable/_
#
# @callbackInput
#   storage inv_gui:data in
#       listener?: any
#
# @within function inv_gui:core/common/api/build/create_menu/set_item/_

## Backup in
data modify storage inv_gui:temp/build in set from storage inv_gui:data in
data remove storage inv_gui:data in


# Set callback return value
data modify storage inv_gui:data callback.id set from storage inv_gui:temp/build in.id
data modify storage inv_gui:data callback.key set from storage inv_gui:temp Content
data modify storage inv_gui:data callback.slot set from storage inv_gui:temp Slot

# Callback
execute if entity @s[type=minecraft:chest_minecart] run function inv_gui:core/common/api/build/create_menu/set_item/item_type/variable/chest_minecart
execute if entity @s[type=minecraft:player] run function inv_gui:core/common/api/build/create_menu/set_item/item_type/variable/ender_chest

# Reset
data remove storage inv_gui:data callback


# Set listener on retrieved item
item modify block 10000 0 10000 container.0 inv_gui:set_listener

# Reset
data remove storage inv_gui:data in


# Place retrieved item
data modify storage inv_gui:temp TargetSlot set from storage inv_gui:temp Slot
function inv_gui:core/common/api/build/place_item/_


## Set in
data modify storage inv_gui:data in set from storage inv_gui:temp/build in
data remove storage inv_gui:temp/build in
