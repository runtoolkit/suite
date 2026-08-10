#> inv_gui:util/map/core/set/update_map/_
# @within function inv_gui:util/map/core/set/_

# Copy target Map
data modify storage inv_gui:util/temp TargetElements set from storage inv_gui:util in.map

# Move element with specified key to TargetElements[-1]
function inv_gui:util/map/core/set/update_map/element/move


# Specified key found -> Update Map
execute if data storage inv_gui:util/temp {Result:false} run function inv_gui:util/map/core/set/update_map/update

# Specified key not found -> Add element to Map
execute if data storage inv_gui:util/temp {Result:true} run function inv_gui:util/map/core/set/update_map/add


# Reset
data remove storage inv_gui:util/temp TargetElements
data remove storage inv_gui:util/temp DeletedElements
data remove storage inv_gui:util/temp Key
data remove storage inv_gui:util/temp Result
