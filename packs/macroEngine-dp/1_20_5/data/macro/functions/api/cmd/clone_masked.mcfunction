execute unless function macro:debug/tools/utils/check_all run return 0

execute if data storage macro:engine {sandbox:1b} run data modify storage macro:engine _sandbox_cmd set value "clone_masked"
execute if data storage macro:engine {sandbox:1b} run execute unless function macro:api/cmd/internal/sandbox_gate run return 0
$clone $(x1) $(y1) $(z1) $(x2) $(y2) $(z2) $(dx) $(dy) $(dz) masked
tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/clone_masked ","color":"aqua"}]}
