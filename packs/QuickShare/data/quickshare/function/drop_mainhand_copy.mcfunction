# Called by quickshare:share with execution at the player.
# Summons a marker item entity, copies the player's mainhand item slot into
# it via /data (this is the standard "clone an item stack via NBT" pattern
# for datapacks, since there's no direct "give a copy of this slot" command),
# then lets it exist as a normal dropped item.
summon minecraft:item ~ ~1 ~ {Item:{id:"minecraft:air",count:1},PickupDelay:10,Tags:["qs_pending"]}
execute as @e[type=minecraft:item,tag=qs_pending,limit=1,sort=nearest] run data modify entity @s Item set from entity @p SelectedItem
execute as @e[type=minecraft:item,tag=qs_pending,limit=1,sort=nearest] if data entity @s Item.id run tag @s remove qs_pending
execute as @e[type=minecraft:item,tag=qs_pending] run kill @s
