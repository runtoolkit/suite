#> inv_gui:core/api/register_item/button/register_local_item
# @within function inv_gui:core/api/register_item/button/_

# Get slot to save item
function inv_gui:core/common/api/register_item/get_slot_index

# Save item
data modify storage inv_gui:temp TargetSlot set from storage inv_gui:temp Slot
function inv_gui:core/common/api/register_item/save_item/_


# Compose LocalItemInfo
data modify storage inv_gui:temp ItemInfo.ItemType set from storage inv_gui:temp ItemType
data modify storage inv_gui:temp ItemInfo.Slot set from storage inv_gui:temp Slot

# Set in LocalItemInfoMap
function inv_gui:core/common/api/register_item/set_local_map


# Reset
data remove storage inv_gui:temp Slot
