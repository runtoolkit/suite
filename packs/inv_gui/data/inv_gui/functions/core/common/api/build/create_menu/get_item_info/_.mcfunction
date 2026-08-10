#> inv_gui:core/common/api/build/create_menu/get_item_info/_
#
# Return ItemInfo for the specified key
#
# @input
#   storage inv_gui:temp
#       Key: string
#           Key of the element to get
#
# @output
#   storage inv_gui:temp
#       ItemInfo: ItemInfo
#           Retrieved ItemInfo
#       isGlobalItemInfo: boolean
#           Whether it is GlobalItemInfo
#
# @within function inv_gui:core/common/api/build/create_menu/set_item/_

# Get from LocalItemInfoMap
function inv_gui:core/common/api/build/create_menu/get_item_info/from_local_map

# Get from GlobalItemInfoMap
execute if data storage inv_gui:util out{contains:false} run function inv_gui:core/common/api/build/create_menu/get_item_info/from_global_map


# Initialize util
function inv_gui:util/cleanup

# Reset
data remove storage inv_gui:temp Key
