$execute as @a[name=$(player),limit=1] at @s if items entity @s contents $(item)[minecraft:custom_data=$(customData)] run $(invoke)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"inv/player_if_item ","color":"aqua"},{"text":"$(player)","color":"white"}]
