# macroengine:api/cb/run_delayed
# ─────────────────────────────────────────────────────────────────
# Schedules a command string to execute via command block after a delay.
#
# INPUT (storage macroengine:input cb):
# cmd (string) — the command to run [REQUIRED]
# delay (int) — delay in ticks [REQUIRED, min 1]
# x (int) — CB block X [default: 0]
# y (int) — CB block Y [default: -64]
# z (int) — CB block Z [default: 0]
#
# SECURITY: caller must hold macroengine.perm_level >= security.cmd_min_level.
#
# EXAMPLE:
# data modify storage macroengine:input cb set value {cmd:"say delayed!",delay:40}
# function macroengine:api/cb/run_delayed
# ─────────────────────────────────────────────────────────────────

# Security gate

# Verify required inputs
execute unless data storage macroengine:input cb.cmd run tellraw @s [{"text":"[MACROENGINE/cb] ","color":"#00AAAA","bold":true},{"text":"cb.cmd not set","color":"red"}]
execute unless data storage macroengine:input cb.cmd run return 0
execute unless data storage macroengine:input cb.delay run tellraw @s [{"text":"[MACROENGINE/cb] ","color":"#00AAAA","bold":true},{"text":"cb.delay not set","color":"red"}]
execute unless data storage macroengine:input cb.delay run return 0

# Fill coordinate defaults
function macroengine:core/internal/api/cb/apply_defaults

# Push to delay queue and schedule flush
function macroengine:core/internal/systems/cb/queue_push with storage macroengine:input cb
data remove storage macroengine:input cb
