# Block found!
# Increment hook.placed scoreboard
scoreboard players add @s macroengine.hook_placed 1

# Write to hook event storage (other systems can listen)
# Save block coordinates (via marker summon from positioned context)
summon minecraft:marker ~ ~ ~ {Tags:["macroengine.hook_block_pos"]}
execute store result storage macroengine:hook placed.x int 1 run data get entity @e[type=minecraft:marker,tag=macroengine.hook_block_pos,limit=1] Pos[0]
execute store result storage macroengine:hook placed.y int 1 run data get entity @e[type=minecraft:marker,tag=macroengine.hook_block_pos,limit=1] Pos[1]
execute store result storage macroengine:hook placed.z int 1 run data get entity @e[type=minecraft:marker,tag=macroengine.hook_block_pos,limit=1] Pos[2]
kill @e[type=minecraft:marker,tag=macroengine.hook_block_pos,limit=1]

# Record timestamp (from macroengine.time scoreboard)
execute store result storage macroengine:hook placed.tick int 1 run scoreboard players get #time macroengine.time

# Get player UUID and name via macroengine modules
execute as @s run function macroengine:systems/uuid/from_entity
data modify storage macroengine:hook placed.uuid set from storage macroengine:input value

execute as @s run function macroengine:player/get_name
data modify storage macroengine:hook placed.name set from storage macroengine:names temp.NAME
data modify storage macroengine:hook placed.uuid_array set from storage macroengine:names temp.UUID

# Set hook event flag
data modify storage macroengine:hook placed.active set value 1b

# Hook event sistemine "placed_block" event'i fire et
data modify storage macroengine:engine _hook_fire_tmp set value {event:"placed_block"}
execute as @s run function macroengine:core/internal/systems/hook/fire with storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_fire_tmp

# Legacy event system support (if present)
execute if score #m_hook macroengine.Flags matches 1.. run function macroengine:events/fire {id:"hook.placed"}

# Cleanup: reset counter
scoreboard players reset @s macroengine.tmp
