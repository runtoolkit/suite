# example_pack:load
# Runs once on /reload or world load.
# Declares the scoreboard objectives this pack uses.

scoreboard objectives add ep.loaded dummy
scoreboard objectives add ep.playtime minecraft.custom:minecraft.play_one_minute

# Guard: only run setup once
scoreboard players add #initialized ep.loaded 0
execute if score #initialized ep.loaded matches 1 run return 0

# First-time setup
scoreboard players set #initialized ep.loaded 1

tellraw @a {"text":"[example-pack] Loaded v1.0.0","color":"green"}
