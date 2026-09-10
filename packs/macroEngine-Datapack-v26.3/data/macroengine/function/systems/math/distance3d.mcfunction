$scoreboard players set $d3d_x1 macroengine.tmp $(x1)
$scoreboard players set $d3d_y1 macroengine.tmp $(y1)
$scoreboard players set $d3d_z1 macroengine.tmp $(z1)
$scoreboard players set $d3d_x2 macroengine.tmp $(x2)
$scoreboard players set $d3d_y2 macroengine.tmp $(y2)
$scoreboard players set $d3d_z2 macroengine.tmp $(z2)

scoreboard players operation $d3d_dx macroengine.tmp = $d3d_x2 macroengine.tmp
scoreboard players operation $d3d_dx macroengine.tmp -= $d3d_x1 macroengine.tmp

scoreboard players operation $d3d_dy macroengine.tmp = $d3d_y2 macroengine.tmp
scoreboard players operation $d3d_dy macroengine.tmp -= $d3d_y1 macroengine.tmp

scoreboard players operation $d3d_dz macroengine.tmp = $d3d_z2 macroengine.tmp
scoreboard players operation $d3d_dz macroengine.tmp -= $d3d_z1 macroengine.tmp

# Overflow prevention: 3 * 26754² = 2,147,329,548 ≤ INT_MAX (2,147,483,647)
execute if score $d3d_dx macroengine.tmp matches 26755.. run scoreboard players set $d3d_dx macroengine.tmp 26754
execute if score $d3d_dx macroengine.tmp matches ..-26755 run scoreboard players set $d3d_dx macroengine.tmp -26754
execute if score $d3d_dy macroengine.tmp matches 26755.. run scoreboard players set $d3d_dy macroengine.tmp 26754
execute if score $d3d_dy macroengine.tmp matches ..-26755 run scoreboard players set $d3d_dy macroengine.tmp -26754
execute if score $d3d_dz macroengine.tmp matches 26755.. run scoreboard players set $d3d_dz macroengine.tmp 26754
execute if score $d3d_dz macroengine.tmp matches ..-26755 run scoreboard players set $d3d_dz macroengine.tmp -26754

scoreboard players operation $d3d_dx macroengine.tmp *= $d3d_dx macroengine.tmp
scoreboard players operation $d3d_dy macroengine.tmp *= $d3d_dy macroengine.tmp
scoreboard players operation $d3d_dz macroengine.tmp *= $d3d_dz macroengine.tmp
scoreboard players operation $d3d_sq macroengine.tmp = $d3d_dx macroengine.tmp
scoreboard players operation $d3d_sq macroengine.tmp += $d3d_dy macroengine.tmp
scoreboard players operation $d3d_sq macroengine.tmp += $d3d_dz macroengine.tmp

execute if score $d3d_sq macroengine.tmp matches 0 run data modify storage macroengine:output result set value 0
execute if score $d3d_sq macroengine.tmp matches 0 run return 0

scoreboard players operation $sqrt_n macroengine.tmp = $d3d_sq macroengine.tmp
scoreboard players set $sqrt_lo macroengine.tmp 0
scoreboard players operation $sqrt_hi macroengine.tmp = $sqrt_n macroengine.tmp
execute if score $sqrt_hi macroengine.tmp matches 46342.. run scoreboard players set $sqrt_hi macroengine.tmp 46341
scoreboard players set $sqrt_itr macroengine.tmp 16
function macroengine:core/internal/systems/math/sqrt_step

execute store result storage macroengine:output result int 1 run scoreboard players get $sqrt_lo macroengine.tmp
