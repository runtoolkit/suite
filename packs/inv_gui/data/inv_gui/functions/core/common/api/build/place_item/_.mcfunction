#> inv_gui:core/common/api/build/place_item/_
#
# Place specified item in the creation shulker box
#
# @input
#   vector 10000 0 10000
#       container.0
#           Item to place
#   storage inv_gui:temp
#       TargetSlot: byte
#           Slot to place in
#
# @within function inv_gui:core/**

# Place in creation shulker box (macro: container slot = TargetSlot)
function inv_gui:core/common/api/build/place_item/put with storage inv_gui:temp

# Reset
item replace block 10000 0 10000 container.0 with minecraft:air
data remove storage inv_gui:temp TargetSlot
