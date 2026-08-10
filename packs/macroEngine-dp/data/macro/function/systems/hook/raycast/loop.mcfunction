# Raycast loop
# Check if there is a non-air block at the current position

# Non-air block found → call found function
execute unless block ~ ~ ~ #minecraft:air run return run function macro:systems/hook/raycast/found

# Still air → continue
# Increment counter
scoreboard players add @s macro.tmp 1

# Stop if max distance reached (50 steps = 5 blocks)
execute if score @s macro.tmp matches 50.. run return 0

# Advance position by 0.1 blocks and try again
execute positioned ^ ^ ^0.1 run function macro:systems/hook/raycast/loop
