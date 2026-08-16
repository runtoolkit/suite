$scoreboard players set $d2d_x1 macroengine.tmp $(x1)
$scoreboard players set $d2d_z1 macroengine.tmp $(z1)
$scoreboard players set $d2d_x2 macroengine.tmp $(x2)
$scoreboard players set $d2d_z2 macroengine.tmp $(z2)

scoreboard players operation $d2d_dx macroengine.tmp = $d2d_x2 macroengine.tmp
scoreboard players operation $d2d_dx macroengine.tmp -= $d2d_x1 macroengine.tmp

scoreboard players operation $d2d_dz macroengine.tmp = $d2d_z2 macroengine.tmp
scoreboard players operation $d2d_dz macroengine.tmp -= $d2d_z1 macroengine.tmp

# Overflow prevention: 2 * 32767² = 2,147,354,578 ≤ INT_MAX (2,147,483,647)
execute if score $d2d_dx macroengine.tmp matches 32768.. run scoreboard players set $d2d_dx macroengine.tmp 32767
execute if score $d2d_dx macroengine.tmp matches ..-32768 run scoreboard players set $d2d_dx macroengine.tmp -32767
execute if score $d2d_dz macroengine.tmp matches 32768.. run scoreboard players set $d2d_dz macroengine.tmp 32767
execute if score $d2d_dz macroengine.tmp matches ..-32768 run scoreboard players set $d2d_dz macroengine.tmp -32767

scoreboard players operation $d2d_dx macroengine.tmp *= $d2d_dx macroengine.tmp
scoreboard players operation $d2d_dz macroengine.tmp *= $d2d_dz macroengine.tmp
scoreboard players operation $d2d_sq macroengine.tmp = $d2d_dx macroengine.tmp
scoreboard players operation $d2d_sq macroengine.tmp += $d2d_dz macroengine.tmp

execute if score $d2d_sq macroengine.tmp matches 0 run data modify storage macroengine:output result set value 0
execute if score $d2d_sq macroengine.tmp matches 0 run return 0

scoreboard players operation $sqrt_n macroengine.tmp = $d2d_sq macroengine.tmp
scoreboard players set $sqrt_lo macroengine.tmp 0
scoreboard players operation $sqrt_hi macroengine.tmp = $sqrt_n macroengine.tmp
execute if score $sqrt_hi macroengine.tmp matches 46342.. run scoreboard players set $sqrt_hi macroengine.tmp 46341
scoreboard players set $sqrt_itr macroengine.tmp 16
function macroengine:core/internal/systems/math/sqrt_step

execute store result storage macroengine:output result int 1 run scoreboard players get $sqrt_lo macroengine.tmp
