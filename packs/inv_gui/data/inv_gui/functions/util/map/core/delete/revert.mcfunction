#> inv_gui:util/map/core/delete/revert
# @within function
#   inv_gui:util/map/core/delete/_
#   inv_gui:util/map/core/delete/revert

# Append last array element to the end
data modify storage inv_gui:util out.map append from storage inv_gui:util/temp DeletedElements[-1]
data remove storage inv_gui:util/temp DeletedElements[-1]

# Recurse until all elements are restored
execute if data storage inv_gui:util/temp DeletedElements[-1] run function inv_gui:util/map/core/delete/revert
