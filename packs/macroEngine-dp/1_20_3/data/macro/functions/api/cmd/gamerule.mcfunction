execute unless function macro:debug/tools/utils/check_all run return 0

$gamerule $(rule) $(value)
$tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/gamerule ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(rule)","color":"aqua"}]}
