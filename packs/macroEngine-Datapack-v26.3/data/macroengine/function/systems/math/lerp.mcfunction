$scoreboard players set $lerp_a macroengine.tmp $(a)
$scoreboard players set $lerp_b macroengine.tmp $(b)
$scoreboard players set $lerp_t macroengine.tmp $(t)

scoreboard players operation $lerp_r macroengine.tmp = $lerp_b macroengine.tmp
scoreboard players operation $lerp_r macroengine.tmp -= $lerp_a macroengine.tmp

scoreboard players operation $lerp_r macroengine.tmp *= $lerp_t macroengine.tmp
scoreboard players set $lerp_100 macroengine.tmp 100
scoreboard players operation $lerp_r macroengine.tmp /= $lerp_100 macroengine.tmp
scoreboard players operation $lerp_r macroengine.tmp += $lerp_a macroengine.tmp

execute store result storage macroengine:output result int 1 run scoreboard players get $lerp_r macroengine.tmp
