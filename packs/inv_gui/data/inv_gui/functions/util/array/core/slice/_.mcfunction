#> inv_gui:util/array/core/slice/_
#
# @input
#   storage inv_gui:util in
#       array: any[]
#       start?: int
#       end?: int
#
# @output
#   storage inv_gui:util out
#       array: any[]
#
# @within function inv_gui:util/array/slice

#>
# @private
#declare score_holder $End
#declare score_holder $Start

#>
# @within inv_gui:util/array/core/slice/**
#declare score_holder $Index


# Initialize arguments
execute unless data storage inv_gui:util in.end run data modify storage inv_gui:util in.end set value 2147483647
execute unless data storage inv_gui:util in.start run data modify storage inv_gui:util in.start set value 0

# Initialize return value
data modify storage inv_gui:util out.array set value []


# Get value
execute store result score $End inv_gui run data get storage inv_gui:util in.end
execute store result score $Start inv_gui run data get storage inv_gui:util in.start

# Remove elements from end onward
execute store result score $Index inv_gui if data storage inv_gui:util in.array[]
scoreboard players operation $Index inv_gui -= $End inv_gui
execute if score $Index inv_gui matches 1.. run function inv_gui:util/array/core/slice/remove

# Extract elements from start onward
execute store result score $Index inv_gui if data storage inv_gui:util in.array[]
scoreboard players operation $Index inv_gui -= $Start inv_gui
execute if score $Index inv_gui matches 1.. run function inv_gui:util/array/core/slice/move


# Reverse element order
data modify storage inv_gui:util in.array set from storage inv_gui:util/temp Sliced
function inv_gui:util/array/reverse


# Reset
scoreboard players reset $End inv_gui
scoreboard players reset $Start inv_gui
scoreboard players reset $Index inv_gui
data remove storage inv_gui:util/temp Sliced
data remove storage inv_gui:util in
