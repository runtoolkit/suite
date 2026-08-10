#> inv_gui:util/map/core/set/update_map/element/move
# @within function
#   inv_gui:util/map/core/set/update_map/_
#   inv_gui:util/map/core/set/update_map/element/move

# Test if the key at the end of the array matches
data modify storage inv_gui:util/temp Key set from storage inv_gui:util/temp TargetElements[-1].key
execute store success storage inv_gui:util/temp Result byte 1.0 run data modify storage inv_gui:util/temp Key set from storage inv_gui:util in.key

# Key doesn't match -> Move last array element to another data
execute if data storage inv_gui:util/temp {Result:true} run data modify storage inv_gui:util/temp DeletedElements append from storage inv_gui:util/temp TargetElements[-1]
execute if data storage inv_gui:util/temp {Result:true} run data remove storage inv_gui:util/temp TargetElements[-1]

# Recurse until key matches or all elements are searched
execute if data storage inv_gui:util/temp {Result:true} if data storage inv_gui:util/temp TargetElements[-1] run function inv_gui:util/map/core/set/update_map/element/move
