#> inv_gui:util/array/core/slice/move
# @within function
#   inv_gui:util/array/core/slice/_
#   inv_gui:util/array/core/slice/move

# Extract element
data modify storage inv_gui:util/temp Sliced append from storage inv_gui:util in.array[-1]
data remove storage inv_gui:util in.array[-1]
scoreboard players remove $Index inv_gui 1

# Recurse until all elements are extracted
execute if score $Index inv_gui matches 1.. run function inv_gui:util/array/core/slice/move
