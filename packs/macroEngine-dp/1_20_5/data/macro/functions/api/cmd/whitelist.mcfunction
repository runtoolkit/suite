execute unless function macro:debug/tools/utils/check_all run return 0
execute unless entity @s[type=minecraft:player] run return 0
execute unless dimension minecraft:overworld run return 0
execute unless entity @s[gamemode=creative] run return 0

# ─────────────────────────────────────────────────────────────────
# SANDBOX GUARD — sandbox modunda tehlikeli komutlar engellenir.
# Aktif:  /data modify storage macro:engine sandbox set value 1b
# Pasif:  /data modify storage macro:engine sandbox set value 0b
# ─────────────────────────────────────────────────────────────────
execute if data storage macro:engine {sandbox:1b} run data modify storage macro:engine _sandbox_cmd set value "whitelist"
execute if data storage macro:engine {sandbox:1b} run execute unless function macro:api/cmd/internal/sandbox_gate run return 0
$whitelist $(action) $(player)
$tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/whitelist ","color":"aqua"},{"text":"$(action) $(player)","color":"white"}]}
