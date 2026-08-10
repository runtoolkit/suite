#> inv_gui:util/array/core/slice/remove
# @within function
#   inv_gui:util/array/core/slice/_
#   inv_gui:util/array/core/slice/remove

# Remove element
data remove storage inv_gui:util in.array[-1]
scoreboard players remove $Index inv_gui 1

# Recurse until all elements are removed
execute if score $Index inv_gui matches 1.. run function inv_gui:util/array/core/slice/remove
