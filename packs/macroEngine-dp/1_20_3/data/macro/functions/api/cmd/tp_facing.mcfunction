execute unless function macro:debug/tools/utils/check_all run return 0
execute unless entity @s[type=minecraft:player] run return 0
execute unless dimension minecraft:overworld run return 0
execute unless entity @s[gamemode=creative] run return 0

$execute as @a[name=$(player),limit=1] at @s run tp @s $(x) $(y) $(z) facing $(fx) $(fy) $(fz)
$tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/tp_facing ","color":"aqua"},{"text":"$(player)","color":"white"}]}
