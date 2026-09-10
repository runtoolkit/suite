# ======================================================================================
# macroengine:input/private/lectern_ray_loop  [INTERNAL]
# ======================================================================================

execute if block ~ ~ ~ minecraft:lectern run return run function macroengine:input/private/lectern_capture

scoreboard players add @s macroengine.tmp 1
execute if score @s macroengine.tmp matches 50.. run return 0
execute positioned ^ ^ ^0.1 run function macroengine:input/private/lectern_ray_loop
