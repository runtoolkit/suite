#> inv_gui:core/api/register_item/variable/register_local_item
# @within function inv_gui:core/api/register_item/variable/_

# Compose LocalItemInfo
data modify storage inv_gui:temp ItemInfo.ItemType set from storage inv_gui:temp ItemType
data modify storage inv_gui:temp ItemInfo.Slot set value 0b

# Set in LocalItemInfoMap
function inv_gui:core/common/api/register_item/set_local_map
