$scoreboard players set $clamp_v macroengine.tmp $(value)
$scoreboard players set $clamp_lo macroengine.tmp $(min)
$scoreboard players set $clamp_hi macroengine.tmp $(max)

execute if score $clamp_v macroengine.tmp < $clamp_lo macroengine.tmp run scoreboard players operation $clamp_v macroengine.tmp = $clamp_lo macroengine.tmp
execute if score $clamp_v macroengine.tmp > $clamp_hi macroengine.tmp run scoreboard players operation $clamp_v macroengine.tmp = $clamp_hi macroengine.tmp

execute store result storage macroengine:output result int 1 run scoreboard players get $clamp_v macroengine.tmp
