
$item modify entity @a[name=$(player),limit=1] $(slot) $(modifier)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cmd/item_modify ","color":"aqua"},{"text":"$(player)","color":"white"}]
