#> inv_gui:core/common/api/build/create_menu/_
#
# Create menu
#
# @input
#   storage inv_gui:data in
#       id: any
#           Identifier of the menu to create
#       contents: (string[] @ 9)[] @ 3
#           Contents of the menu to create
#
# @output
#   vector 10000 2 10000
#       container.0~26
#           Created menu
#
# @within function inv_gui:core/api/build/**

#>
# @within function
#   inv_gui:core/common/api/build/**
#declare score_holder $Slot


# Flatten contents
data modify storage inv_gui:util in.array set from storage inv_gui:data in.contents
function inv_gui:util/array/flat

# Assign contents
data modify storage inv_gui:temp Contents set from storage inv_gui:util out.array
function inv_gui:util/cleanup


# Set the slot where item placement starts
execute store result score $Slot inv_gui if data storage inv_gui:temp Contents[]
scoreboard players remove $Slot inv_gui 1

# Place item
function inv_gui:core/common/api/build/create_menu/loop


# Reset
scoreboard players reset $Slot inv_gui
data remove storage inv_gui:temp Contents
data remove storage inv_gui:temp Content
data remove storage inv_gui:temp Slot
data remove storage inv_gui:temp ItemInfo
data remove storage inv_gui:temp isGlobalItemInfo
