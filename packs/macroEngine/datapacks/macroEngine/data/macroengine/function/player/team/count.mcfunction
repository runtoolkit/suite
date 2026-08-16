scoreboard players set $team_cnt macroengine.tmp 0
$execute as @a[team=$(team)] run scoreboard players add $team_cnt macroengine.tmp 1
execute store result storage macroengine:output result int 1 run scoreboard players get $team_cnt macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"team/count ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(team)","color":"aqua"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
