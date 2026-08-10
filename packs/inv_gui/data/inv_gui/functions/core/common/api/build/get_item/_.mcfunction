#> inv_gui:core/common/api/build/get_item/_
#
# Retrieve specified item from the storage shulker box
#
# @input
#   storage inv_gui:temp
#       TargetSlot: byte
#           Slot to get
#
# @output
#   vector 10000 0 10000
#       container.0
#           Retrieved item
#
# @within function inv_gui:core/**

# Retrieve from storage shulker box (macro: container slot = TargetSlot)
function inv_gui:core/common/api/build/get_item/fetch with storage inv_gui:temp

# Reset
data remove storage inv_gui:temp TargetSlot
