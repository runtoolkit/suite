# Raycast start
# Reset distance counter (max 50 steps = 5 blocks)
scoreboard players set @s macroengine.tmp 0

# Start loop
function macroengine:systems/hook/raycast/loop
