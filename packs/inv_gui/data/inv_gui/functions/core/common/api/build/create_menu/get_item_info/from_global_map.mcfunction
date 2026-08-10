#> inv_gui:core/common/api/build/create_menu/get_item_info/from_global_map
# @within function inv_gui:core/common/api/build/create_menu/get_item_info/_

# Get registered element (GlobalItemInfoMap)
data modify storage inv_gui:util in.map set from storage inv_gui:core GlobalItemInfoMap
data modify storage inv_gui:util in.key set from storage inv_gui:temp Key
function inv_gui:util/map/get


# Return retrieved ItemInfo
execute if data storage inv_gui:util out{contains:true} run data modify storage inv_gui:temp ItemInfo set from storage inv_gui:util out.value

# Return whether it is GlobalItemInfo
execute if data storage inv_gui:util out{contains:true} run data modify storage inv_gui:temp isGlobalItemInfo set value true
