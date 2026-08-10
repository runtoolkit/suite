#> inv_gui:core/common/api/build/create_menu/set_item/_
#
# Place item
#
# @input
#   storage inv_gui:temp/build
#       Slot: byte
#           Slot of the item to place
#       Content: string
#           Key of the item to place
#
# @within function inv_gui:core/common/api/build/create_menu/loop

# Get ItemInfo
data modify storage inv_gui:temp Key set from storage inv_gui:temp Content
function inv_gui:core/common/api/build/create_menu/get_item_info/_

# Processing per ItemType
execute if data storage inv_gui:temp ItemInfo{ItemType:"Normal"} run function inv_gui:core/common/api/build/create_menu/set_item/item_type/normal/_
execute if data storage inv_gui:temp ItemInfo{ItemType:"Button"} run function inv_gui:core/common/api/build/create_menu/set_item/item_type/button/_
execute if data storage inv_gui:temp ItemInfo{ItemType:"Variable"} run function inv_gui:core/common/api/build/create_menu/set_item/item_type/variable/_
