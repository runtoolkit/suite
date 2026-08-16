
$execute store result storage macroengine:output result int 1 run xp query @a[name=$(player),limit=1] $(type)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/xp_get ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(type)","color":"aqua"}]
