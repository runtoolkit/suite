execute unless function macro:debug/tools/utils/check_all run return 0

$loot spawn $(x) $(y) $(z) loot $(loot_table)
tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/loot_drop ","color":"aqua"}]}
