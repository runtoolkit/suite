#> inv_gui:core/api/register_item/variable/_
#
# @input
#   storage inv_gui:data in
#       key: string
#       isGlobal?: boolean
#
# @within function inv_gui:api/register_item/variable

# Specify default arguments
execute unless data storage inv_gui:data in.isGlobal run data modify storage inv_gui:data in.isGlobal set value false


# Set item type
data modify storage inv_gui:temp ItemType set value "Variable"

# Add to each Map
execute if data storage inv_gui:data in{isGlobal:0b} run function inv_gui:core/api/register_item/variable/register_local_item
execute if data storage inv_gui:data in{isGlobal:1b} run function inv_gui:core/api/register_item/variable/register_global_item


# Reset
data remove storage inv_gui:temp ItemType
data remove storage inv_gui:data in
