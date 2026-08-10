execute unless function macro:debug/tools/utils/check_all run return 0

execute if data storage macro:engine {sandbox:1b} run data modify storage macro:engine _sandbox_cmd set value "place_feature"
execute if data storage macro:engine {sandbox:1b} run execute unless function macro:api/cmd/internal/sandbox_gate run return 0
$place feature $(feature) $(x) $(y) $(z)
$tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/place_feature ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(feature)","color":"aqua"}]}
