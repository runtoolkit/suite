$scoreboard players set $max_a macroengine.tmp $(a)
$scoreboard players set $max_b macroengine.tmp $(b)

execute store result storage macroengine:output result int 1 run scoreboard players get $max_a macroengine.tmp

execute if score $max_b macroengine.tmp > $max_a macroengine.tmp run execute store result storage macroengine:output result int 1 run scoreboard players get $max_b macroengine.tmp
