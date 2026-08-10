#> inv_gui:util/map/core/set/update_map/add
# @within function inv_gui:util/map/core/set/update_map/_

# Create element with key and value
data modify storage inv_gui:util/temp Element.key set from storage inv_gui:util in.key
data modify storage inv_gui:util/temp Element.value set from storage inv_gui:util in.value

# Return Map containing the added element
data modify storage inv_gui:util out.map set from storage inv_gui:util in.map
data modify storage inv_gui:util out.map append from storage inv_gui:util/temp Element

# Reset
data remove storage inv_gui:util/temp Element
