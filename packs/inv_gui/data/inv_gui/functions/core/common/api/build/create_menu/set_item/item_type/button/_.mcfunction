#> inv_gui:core/common/api/build/create_menu/set_item/item_type/button/_
# @within function inv_gui:core/common/api/build/create_menu/set_item/_

# Get corresponding item
execute if data storage inv_gui:temp {isGlobalItemInfo:0b} run data modify storage inv_gui:temp TargetSlot set from storage inv_gui:temp ItemInfo.Slot
execute if data storage inv_gui:temp {isGlobalItemInfo:0b} run function inv_gui:core/common/api/build/get_item/_
execute if data storage inv_gui:temp {isGlobalItemInfo:1b} run data modify block 10000 0 10000 Items append from storage inv_gui:temp ItemInfo.Item

# Place retrieved item
data modify storage inv_gui:temp TargetSlot set from storage inv_gui:temp Slot
function inv_gui:core/common/api/build/place_item/_
