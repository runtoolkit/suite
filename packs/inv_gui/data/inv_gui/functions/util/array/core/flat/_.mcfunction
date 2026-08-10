#> inv_gui:util/array/core/flat/_
#
# @input
#   storage inv_gui:util in
#       array: any[]
#
# @output
#   storage inv_gui:util out
#       array: any[]
#
# @within function inv_gui:util/array/flat

# Flatten recursively
data modify storage inv_gui:util/temp ArrayList append from storage inv_gui:util in.array
function inv_gui:util/array/core/flat/loop

# Reverse element order
data modify storage inv_gui:util in.array set from storage inv_gui:util/temp Flattened
function inv_gui:util/array/reverse

# Reset
data remove storage inv_gui:util/temp ArrayList
data remove storage inv_gui:util/temp Flattened
data remove storage inv_gui:util/temp isListTag
data remove storage inv_gui:util in
