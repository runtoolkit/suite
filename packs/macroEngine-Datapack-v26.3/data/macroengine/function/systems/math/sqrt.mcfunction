$scoreboard players set $sqrt_n macroengine.tmp $(value)

execute if score $sqrt_n macroengine.tmp matches ..0 run data modify storage macroengine:output result set value 0
execute if score $sqrt_n macroengine.tmp matches ..0 run return 0

execute if score $sqrt_n macroengine.tmp matches 1 run data modify storage macroengine:output result set value 1
execute if score $sqrt_n macroengine.tmp matches 1 run return 0

scoreboard players set $sqrt_lo macroengine.tmp 0
scoreboard players operation $sqrt_hi macroengine.tmp = $sqrt_n macroengine.tmp
execute if score $sqrt_hi macroengine.tmp matches 46342.. run scoreboard players set $sqrt_hi macroengine.tmp 46341

scoreboard players set $sqrt_itr macroengine.tmp 16
function macroengine:core/internal/systems/math/sqrt_step

execute store result storage macroengine:output result int 1 run scoreboard players get $sqrt_lo macroengine.tmp
