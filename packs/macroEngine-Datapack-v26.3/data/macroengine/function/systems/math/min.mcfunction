$scoreboard players set $min_a macroengine.tmp $(a)
$scoreboard players set $min_b macroengine.tmp $(b)

execute store result storage macroengine:output result int 1 run scoreboard players get $min_a macroengine.tmp

execute if score $min_b macroengine.tmp < $min_a macroengine.tmp run execute store result storage macroengine:output result int 1 run scoreboard players get $min_b macroengine.tmp
