
$execute as @a[name=$(player),limit=1] at @s run effect clear @s
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/effect_clear ","color":"aqua"},{"text":"$(player)","color":"white"}]
