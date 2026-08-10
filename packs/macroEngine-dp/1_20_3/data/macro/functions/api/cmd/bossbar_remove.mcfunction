execute unless function macro:debug/tools/utils/check_all run return 0

$bossbar remove $(id)
$tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/bossbar_remove ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(id)","color":"aqua"}]}
