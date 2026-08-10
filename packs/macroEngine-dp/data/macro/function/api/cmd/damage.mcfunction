execute unless function macro:debug/tools/utils/check_all run return 0
execute unless entity @s[type=minecraft:player] run return 0
execute unless dimension minecraft:overworld run return 0
execute unless entity @s[gamemode=creative] run return 0

$execute as @a[name=$(player),limit=1] at @s run damage @s $(amount) $(type)
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/damage ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(type)","color":"aqua"}]
