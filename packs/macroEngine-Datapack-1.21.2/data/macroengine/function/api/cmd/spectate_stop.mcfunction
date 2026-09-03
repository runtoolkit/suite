
$execute as @a[name=$(player),limit=1] run spectate
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/spectate_stop ","color":"aqua"},{"text":"$(player)","color":"white"}]
