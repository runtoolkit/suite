#> inv_gui:core/emitter/check_item_drop/find_dropped_item/_
# @within function inv_gui:core/emitter/check_item_drop/_

# Get data of dropped item
data modify storage inv_gui:temp ItemEntity set from entity @s

# Check if Thrower and UUID match
execute store success storage inv_gui:temp Result byte 1.0 run data modify storage inv_gui:temp ItemEntity.Thrower set from entity @a[tag=inv_gui.checkItemDrop.this, distance=..5.0, limit=1] UUID

# Thrower and UUID match -> Dropped item is a button -> Dropped item found
execute if data storage inv_gui:temp {Result:false} if data storage inv_gui:temp ItemEntity.Item.tag.inv_gui{isButton:true} run function inv_gui:core/emitter/check_item_drop/found_dropped_item/item
execute if data storage inv_gui:temp {Result:false} if data storage inv_gui:temp ItemEntity.Item.tag.inv_gui{isButton:true} as @a[tag=inv_gui.checkItemDrop.this, distance=..5.0, limit=1] run function inv_gui:core/emitter/check_item_drop/found_dropped_item/player

# Reset
data remove storage inv_gui:temp ItemEntity
data remove storage inv_gui:temp Result
