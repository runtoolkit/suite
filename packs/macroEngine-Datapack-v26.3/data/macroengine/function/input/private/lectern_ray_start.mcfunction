# ======================================================================================
# macroengine:input/private/lectern_ray_start  [INTERNAL]
# ======================================================================================

scoreboard players set @s macroengine.tmp 0
execute anchored eyes positioned ^ ^ ^0.1 run function macroengine:input/private/lectern_ray_loop
