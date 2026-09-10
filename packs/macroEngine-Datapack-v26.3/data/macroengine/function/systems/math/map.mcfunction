$scoreboard players set $map_v macroengine.tmp $(value)
$scoreboard players set $map_imin macroengine.tmp $(in_min)
$scoreboard players set $map_imax macroengine.tmp $(in_max)
$scoreboard players set $map_omin macroengine.tmp $(out_min)
$scoreboard players set $map_omax macroengine.tmp $(out_max)

scoreboard players operation $map_ir macroengine.tmp = $map_imax macroengine.tmp
scoreboard players operation $map_ir macroengine.tmp -= $map_imin macroengine.tmp

execute if score $map_ir macroengine.tmp matches 0 run execute store result storage macroengine:output result int 1 run scoreboard players get $map_omin macroengine.tmp
execute if score $map_ir macroengine.tmp matches 0 run return 0

scoreboard players operation $map_or macroengine.tmp = $map_omax macroengine.tmp
scoreboard players operation $map_or macroengine.tmp -= $map_omin macroengine.tmp

scoreboard players operation $map_off macroengine.tmp = $map_v macroengine.tmp
scoreboard players operation $map_off macroengine.tmp -= $map_imin macroengine.tmp

scoreboard players operation $map_off macroengine.tmp *= $map_or macroengine.tmp
scoreboard players operation $map_off macroengine.tmp /= $map_ir macroengine.tmp
scoreboard players operation $map_off macroengine.tmp += $map_omin macroengine.tmp

execute store result storage macroengine:output result int 1 run scoreboard players get $map_off macroengine.tmp
