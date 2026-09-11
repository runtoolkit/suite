# Clear previous owner tag (multiplayer-safe)
tag @a remove macroengine.cbm_owner
tag @s add macroengine.cbm_owner

# Store owner UUID for later lookup
data modify storage macroengine:input cbm.owner set from entity @s UUID

# Remove any nearby existing input minecart, then summon fresh
kill @e[type=minecraft:command_block_minecart,tag=macroengine_input,distance=..2]
summon minecraft:command_block_minecart ~ ~ ~ {OnGround:1b,UpdateLastExecution:1b,Command:"",Tags:["macroengine_input"],TrackOutput:1b}
