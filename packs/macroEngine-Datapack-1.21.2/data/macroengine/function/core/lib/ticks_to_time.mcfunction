$scoreboard players set $ttt_t macroengine.tmp $(ticks)

execute if score $ttt_t macroengine.tmp matches ..-1 run scoreboard players set $ttt_t macroengine.tmp 0

scoreboard players operation $ttt_r macroengine.tmp = $ttt_t macroengine.tmp
scoreboard players set $ttt_20 macroengine.tmp 20
scoreboard players operation $ttt_r macroengine.tmp %= $ttt_20 macroengine.tmp
execute store result storage macroengine:output ticks int 1 run scoreboard players get $ttt_r macroengine.tmp

scoreboard players operation $ttt_t macroengine.tmp /= $ttt_20 macroengine.tmp

scoreboard players operation $ttt_r macroengine.tmp = $ttt_t macroengine.tmp
scoreboard players set $ttt_60 macroengine.tmp 60
scoreboard players operation $ttt_r macroengine.tmp %= $ttt_60 macroengine.tmp
execute store result storage macroengine:output seconds int 1 run scoreboard players get $ttt_r macroengine.tmp

scoreboard players operation $ttt_t macroengine.tmp /= $ttt_60 macroengine.tmp

scoreboard players operation $ttt_r macroengine.tmp = $ttt_t macroengine.tmp
scoreboard players operation $ttt_r macroengine.tmp %= $ttt_60 macroengine.tmp
execute store result storage macroengine:output minutes int 1 run scoreboard players get $ttt_r macroengine.tmp

scoreboard players operation $ttt_t macroengine.tmp /= $ttt_60 macroengine.tmp
execute store result storage macroengine:output hours int 1 run scoreboard players get $ttt_t macroengine.tmp

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/ticks_to_time ","color":"aqua"},{"text":"($(ticks)t)","color":"gray"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"hours","color":"green"},{"text":"h ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"minutes","color":"green"},{"text":"m ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"seconds","color":"green"},{"text":"s ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"ticks","color":"green"},{"text":"t","color":"gray"}]
