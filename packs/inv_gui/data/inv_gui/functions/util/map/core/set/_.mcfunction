#> inv_gui:util/map/core/set/_
#
# @input
#   storage inv_gui:util in
#       key: any
#       value: any
#       map?: Map
#
# @output
#   storage inv_gui:util out
#       map: Map
#
# @within function inv_gui:util/map/set

# Target Map is specified -> Add/update Map
execute if data storage inv_gui:util in.map run function inv_gui:util/map/core/set/update_map/_

# Target Map not specified -> Create Map
execute unless data storage inv_gui:util in.map run function inv_gui:util/map/core/set/create_map/_

# Reset
data remove storage inv_gui:util in
