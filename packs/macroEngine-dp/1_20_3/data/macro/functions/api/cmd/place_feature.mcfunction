execute unless function macro:debug/tools/utils/check_all run return 0

$place feature $(feature) $(x) $(y) $(z)
$tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/place_feature ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(feature)","color":"aqua"}]}
