scoreboard players set $inv_cnt macroengine.tmp 0
$execute as @a[name=$(player),limit=1] run execute store result score $inv_cnt macroengine.tmp run clear @s *[minecraft:custom_data=$(customData)] 0
execute store result storage macroengine:output count int 1 run scoreboard players get $inv_cnt macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"inv/count_item ","color":"aqua"},{"text":"$(player)","color":"white"}]
