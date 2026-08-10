execute unless function macro:debug/tools/utils/check_all run return 0

$particle $(name) $(x) $(y) $(z) $(dx) $(dy) $(dz) $(speed) $(count)
tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/particle ","color":"aqua"}]}
