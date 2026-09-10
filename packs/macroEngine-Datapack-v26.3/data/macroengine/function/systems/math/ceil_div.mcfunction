$scoreboard players set $cdv_a macroengine.tmp $(a)
$scoreboard players set $cdv_b macroengine.tmp $(b)

scoreboard players operation $cdv_t macroengine.tmp = $cdv_b macroengine.tmp
scoreboard players remove $cdv_t macroengine.tmp 1

scoreboard players operation $cdv_a macroengine.tmp += $cdv_t macroengine.tmp

scoreboard players operation $cdv_a macroengine.tmp /= $cdv_b macroengine.tmp

execute store result storage macroengine:output result int 1 run scoreboard players get $cdv_a macroengine.tmp
