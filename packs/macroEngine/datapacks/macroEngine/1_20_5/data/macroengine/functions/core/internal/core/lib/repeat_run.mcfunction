execute store result score $rep_r macroengine.tmp run data get storage macroengine:engine _repeat.remaining
execute if score $rep_r macroengine.tmp matches ..0 run execute as @a[tag=macroengine.debug] run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/repeat ","color":"aqua"},{"text":"DONE ","color":"green"},{"text":"all iterations completed","color":"#555555"}]
execute if score $rep_r macroengine.tmp matches ..0 run return 0

function macroengine:core/internal/core/lib/repeat_call with storage macroengine:engine _repeat

scoreboard players remove $rep_r macroengine.tmp 1
execute store result storage macroengine:engine _repeat.remaining int 1 run scoreboard players get $rep_r macroengine.tmp
execute store result score $rep_i macroengine.tmp run data get storage macroengine:engine _repeat.i
scoreboard players add $rep_i macroengine.tmp 1
execute store result storage macroengine:engine _repeat.i int 1 run scoreboard players get $rep_i macroengine.tmp

function macroengine:core/internal/core/lib/repeat_run
