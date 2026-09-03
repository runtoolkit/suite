
$execute as @a[name=$(player),limit=1] at @s run locate structure $(structure)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/locate_structure ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(structure)","color":"aqua"}]
