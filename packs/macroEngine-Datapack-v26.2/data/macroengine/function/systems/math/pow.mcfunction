$scoreboard players set $pow_a macroengine.tmp $(a)
$scoreboard players set $pow_n macroengine.tmp $(n)
scoreboard players set $pow_r macroengine.tmp 1

execute if score $pow_n macroengine.tmp matches 0 run execute store result storage macroengine:output result int 1 run scoreboard players get $pow_r macroengine.tmp
execute if score $pow_n macroengine.tmp matches 0 run return 0

function macroengine:core/internal/systems/math/pow_loop
execute store result storage macroengine:output result int 1 run scoreboard players get $pow_r macroengine.tmp
