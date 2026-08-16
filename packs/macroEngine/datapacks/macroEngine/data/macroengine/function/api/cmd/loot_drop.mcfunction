
$loot spawn $(x) $(y) $(z) loot $(loot_table)
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/loot_drop ","color":"aqua"}]
