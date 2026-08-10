execute unless function macro:debug/tools/utils/check_all run return 0

# ─────────────────────────────────────────────────────────────────
# SANDBOX GUARD — sandbox modunda tehlikeli komutlar engellenir.
# Aktif:  /data modify storage macro:engine sandbox set value 1b
# Pasif:  /data modify storage macro:engine sandbox set value 0b
# ─────────────────────────────────────────────────────────────────
execute if data storage macro:engine {sandbox:1b} run data modify storage macro:engine _sandbox_cmd set value "fill"
execute if data storage macro:engine {sandbox:1b} run execute unless function macro:api/cmd/internal/sandbox_gate run return 0
$fill $(x1) $(y1) $(z1) $(x2) $(y2) $(z2) $(block) $(mode)
$tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/fill ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(mode)","color":"aqua"}]}
