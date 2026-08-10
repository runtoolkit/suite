#> inv_gui:util/map/core/delete/_
#
# @input
#   storage inv_gui:util in
#       key: any
#       map: Map
#
# @output
#   storage inv_gui:util out
#       map: Map
#
# @within function inv_gui:util/map/delete

# Copy target Map
data modify storage inv_gui:util out.map set from storage inv_gui:util in.map

# Move element with specified key to out.map[-1]
function inv_gui:util/map/core/delete/move

# Delete element
data remove storage inv_gui:util out.map[-1]

# Restore deleted element
function inv_gui:util/map/core/delete/revert

# Reset
data remove storage inv_gui:util/temp DeletedElements
data remove storage inv_gui:util/temp Key
data remove storage inv_gui:util/temp Result
data remove storage inv_gui:util in
