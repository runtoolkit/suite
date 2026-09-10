execute store result storage macroengine:engine global.tick int 1 run scoreboard players get $tick macroengine.tmp
execute store result storage macroengine:engine global.epoch int 1 run scoreboard players get $epoch macroengine.time
scoreboard players set $tick macroengine.tmp 0
