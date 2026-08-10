#> inv_gui:core/common/api/register_item/set_local_map
#
# Set in LocalItemInfoMap
#
# @input
#   storage inv_gui:temp
#       ItemInfo: LocalItemInfo
#           Value of the element to set
#
# @within function inv_gui:core/api/register_item/*/register_local_item

# Create Map
data modify storage inv_gui:util in.key set from storage inv_gui:data in.key
data modify storage inv_gui:util in.value set from storage inv_gui:temp ItemInfo
data modify storage inv_gui:util in.map set from storage inv_gui:core LocalItemInfoMap
function inv_gui:util/map/set

# Overwrite in LocalItemInfoMap
data modify storage inv_gui:core LocalItemInfoMap set from storage inv_gui:util out.map
function inv_gui:util/cleanup


# Reset
data remove storage inv_gui:temp ItemInfo
