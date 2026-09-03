
$execute store result storage macroengine:output result int 1 run scoreboard players get @a[name=$(player),limit=1] $(objective)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/scoreboard_get ","color":"aqua"},{"text":"$(player)","color":"white"}]
