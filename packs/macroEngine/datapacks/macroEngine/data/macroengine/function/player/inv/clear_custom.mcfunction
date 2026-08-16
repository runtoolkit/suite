$execute as @a[name=$(player),limit=1] run clear @s $(item)[minecraft:custom_data=$(customData)] $(count)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"inv/clear_custom ","color":"aqua"},{"text":"$(player)","color":"white"}]
