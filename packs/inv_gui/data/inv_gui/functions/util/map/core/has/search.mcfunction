#> inv_gui:util/map/core/has/search
# @within function
#   inv_gui:util/map/core/has/_
#   inv_gui:util/map/core/has/search

# Test if the key at the end of the array matches
data modify storage inv_gui:util/temp Key set from storage inv_gui:util in.map[-1].key
execute store success storage inv_gui:util/temp Result byte 1.0 run data modify storage inv_gui:util/temp Key set from storage inv_gui:util in.key

# Key matches -> Return true
execute if data storage inv_gui:util/temp {Result:false} run data modify storage inv_gui:util out.contains set value true

# Key doesn't match -> Delete last array element
execute if data storage inv_gui:util/temp {Result:true} run data remove storage inv_gui:util in.map[-1]

# Recurse until key matches or all elements are searched
execute if data storage inv_gui:util/temp {Result:true} if data storage inv_gui:util in.map[-1] run function inv_gui:util/map/core/has/search
