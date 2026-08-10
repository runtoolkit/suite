execute unless function macro:debug/tools/utils/check_all run return 0

$bossbar add $(id) {"text":"$(text)"}
$bossbar set $(id) color $(color)
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/bossbar_add ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(id)","color":"aqua"}]
