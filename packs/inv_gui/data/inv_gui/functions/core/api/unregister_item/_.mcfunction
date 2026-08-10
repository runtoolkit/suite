#> inv_gui:core/api/unregister_item/_
#
# @input
#   storage inv_gui:data in
#       key: string
#
# @within function inv_gui:api/unregister_item

# Delete from Map
data modify storage inv_gui:util in.key set from storage inv_gui:data in.key
data modify storage inv_gui:util in.map set from storage inv_gui:core GlobalItemInfoMap
function inv_gui:util/map/delete

# Overwrite in GlobalItemInfoMap
data modify storage inv_gui:core GlobalItemInfoMap set from storage inv_gui:util out.map
function inv_gui:util/cleanup

# Reset
data remove storage inv_gui:data in
