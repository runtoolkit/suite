scoreboard players set $poc macroengine.tmp 0
execute as @a run scoreboard players add $poc macroengine.tmp 1
execute store result storage macroengine:output result int 1 run scoreboard players get $poc macroengine.tmp