#> inv_gui:util/map/core/get/_
#
# @input
#   storage inv_gui:util in
#       map: Map
#       key: any
#
# @output
#   storage inv_gui:util out
#       value: any
#       contains: boolean
#
# @within function inv_gui:util/map/get

# Initialize return value
data modify storage inv_gui:util out.contains set value false

# Search for element with specified key
function inv_gui:util/map/core/get/search

# If elements remain in the array, the element for the specified key is contained
execute if data storage inv_gui:util in.map[-1] run data modify storage inv_gui:util out.contains set value true

# Reset
data remove storage inv_gui:util/temp Key
data remove storage inv_gui:util/temp Result
data remove storage inv_gui:util in
