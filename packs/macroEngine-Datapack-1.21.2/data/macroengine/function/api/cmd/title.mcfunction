
$execute as @a[name=$(player),limit=1] at @s run title @s title {"text":"$(text)","color":"$(color)"}
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/title ","color":"aqua"},{"text":"$(player)","color":"white"}]
