#> inv_gui:util/map/core/has/_
#
# @input
#   storage inv_gui:util in
#       key: any
#       map: Map
#
# @output
#   storage inv_gui:util out
#       contains: boolean
#
# @within function inv_gui:util/map/has

# Initialize return value
data modify storage inv_gui:util out.contains set value false

# Search whether element for specified key is contained
function inv_gui:util/map/core/has/search

# Reset
data remove storage inv_gui:util/temp Key
data remove storage inv_gui:util/temp Result
data remove storage inv_gui:util in
