$scoreboard players set $abs_v macroengine.tmp $(value)
scoreboard players set $abs_neg macroengine.tmp -1
execute if score $abs_v macroengine.tmp matches ..-1 run scoreboard players operation $abs_v macroengine.tmp *= $abs_neg macroengine.tmp
execute store result storage macroengine:output result int 1 run scoreboard players get $abs_v macroengine.tmp
