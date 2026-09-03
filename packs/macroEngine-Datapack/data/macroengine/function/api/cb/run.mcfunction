# macroengine:api/cb/run
# ─────────────────────────────────────────────────────────────────
# Executes a raw command string via a temporary command block.
# Zero-delay variant: fires next tick, cleaned up 2t later.
#
# INPUT  (storage macroengine:input cb):
#   cmd   (string)  — the command to run  [REQUIRED]
#   x     (int)     — CB block X          [default: 0]
#   y     (int)     — CB block Y          [default: -64]
#   z     (int)     — CB block Z          [default: 0]
#
# SECURITY: caller must hold macroengine.perm_level >= security.cmd_min_level.
#
# EXAMPLE:
#   data modify storage macroengine:input cb set value {cmd:"say hello"}
#   function macroengine:api/cb/run
# ─────────────────────────────────────────────────────────────────

# Security gate

# Verify required input
execute unless data storage macroengine:input cb.cmd run tellraw @s [{"text":"[MACROENGINE/cb] ","color":"#00AAAA","bold":true},{"text":"cb.cmd not set","color":"red"}]
execute unless data storage macroengine:input cb.cmd run return 0

# Fill coordinate defaults
function macroengine:core/internal/api/cb/apply_defaults

# Execute
function macroengine:core/internal/api/cb/exec with storage macroengine:input cb
data remove storage macroengine:input cb
