execute unless function macro:debug/tools/utils/check_all run return 0

$summon $(entity) $(x) $(y) $(z) $(nbt)
$tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/summon ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(entity)","color":"aqua"}]}
