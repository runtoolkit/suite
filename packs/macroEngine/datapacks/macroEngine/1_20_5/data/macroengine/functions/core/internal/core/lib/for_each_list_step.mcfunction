execute unless data storage macroengine:engine _felist_input[0] run execute as @a[tag=macroengine.debug] run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/for_each_list ","color":"aqua"},{"text":"DONE ","color":"green"},{"text":"list exhausted, loop ended","color":"#555555"}]
execute unless data storage macroengine:engine _felist_input[0] run return 0

data modify storage macroengine:engine _felist_current set from storage macroengine:engine _felist_input[0]
execute store result storage macroengine:engine _felist_i int 1 run scoreboard players get $felist_i macroengine.tmp

function macroengine:core/internal/core/lib/for_each_list_call with storage macroengine:engine _felist_state

data remove storage macroengine:engine _felist_input[0]
scoreboard players add $felist_i macroengine.tmp 1

function macroengine:core/internal/core/lib/for_each_list_step
