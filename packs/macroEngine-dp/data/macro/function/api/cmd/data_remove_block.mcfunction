execute unless function macro:debug/tools/utils/check_all run return 0
execute unless entity @s[type=minecraft:player] run return 0
execute unless dimension minecraft:overworld run return 0
execute unless entity @s[gamemode=creative] run return 0

# ─────────────────────────────────────────────────────────────────
# SANDBOX GUARD — dangerous commands are blocked in sandbox mode.
# Enable:  /data modify storage macro:engine sandbox set value 1b
# Disable: /data modify storage macro:engine sandbox set value 0b
# ─────────────────────────────────────────────────────────────────
execute if data storage macro:engine {sandbox:1b} run data modify storage macro:engine _sandbox_cmd set value "data_remove_block"
execute if data storage macro:engine {sandbox:1b} run execute unless function macro:api/cmd/internal/sandbox_gate run return 0

$data remove block $(x) $(y) $(z) $(path)
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/data_remove_block ","color":"aqua"},{"text":"$(x) $(y) $(z) → $(path)","color":"#555555"}]
