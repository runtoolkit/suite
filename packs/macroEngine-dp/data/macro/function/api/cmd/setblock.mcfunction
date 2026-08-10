execute unless function macro:debug/tools/utils/check_all run return 0

# ─────────────────────────────────────────────────────────────────
# SANDBOX GUARD — dangerous commands are blocked in sandbox mode.
# Enable:  /data modify storage macro:engine sandbox set value 1b
# Disable: /data modify storage macro:engine sandbox set value 0b
# ─────────────────────────────────────────────────────────────────
execute if data storage macro:engine {sandbox:1b} run data modify storage macro:engine _sandbox_cmd set value "setblock"
execute if data storage macro:engine {sandbox:1b} run execute unless function macro:api/cmd/internal/sandbox_gate run return 0

$setblock $(x) $(y) $(z) $(block) $(mode)
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/setblock ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(mode)","color":"aqua"}]
