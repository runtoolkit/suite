#> inv_gui:core/common/api/build/create_menu/loop
# @within function
#   inv_gui:core/common/api/build/create_menu/_
#   inv_gui:core/common/api/build/create_menu/loop

# Set slot of item to place
execute store result storage inv_gui:temp Slot byte 1.0 run scoreboard players get $Slot inv_gui

# Set key of item to place
data modify storage inv_gui:temp Content set from storage inv_gui:temp Contents[-1]
data remove storage inv_gui:temp Contents[-1]

# Place item
function inv_gui:core/common/api/build/create_menu/set_item/_


# Change slot of item to place
scoreboard players remove $Slot inv_gui 1

# Recurse until all items are placed
execute if score $Slot inv_gui matches 0.. run function inv_gui:core/common/api/build/create_menu/loop
