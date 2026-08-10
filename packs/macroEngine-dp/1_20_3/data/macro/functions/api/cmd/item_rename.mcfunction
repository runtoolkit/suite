execute unless function macro:debug/tools/utils/check_all run return 0

$item modify entity @a[name=$(player),limit=1] $(slot) $(modifier)
$tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/item_rename ","color":"aqua"},{"text":"$(player)","color":"white"}]}
