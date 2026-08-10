#> inv_gui:util/map/core/set/update_map/update
# @within function inv_gui:util/map/core/set/update_map/_

# Update value for specified key
data modify storage inv_gui:util/temp TargetElements[-1].value set from storage inv_gui:util in.value

# Restore deleted element
function inv_gui:util/map/core/set/update_map/element/revert

# Return Map containing the updated element
data modify storage inv_gui:util out.map set from storage inv_gui:util/temp TargetElements
