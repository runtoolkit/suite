execute unless function macro:debug/tools/utils/check_all run return 0

$execute as @a[name=$(player),limit=1] at @s run effect clear @s
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/effect_clear ","color":"aqua"},{"text":"$(player)","color":"white"}]
