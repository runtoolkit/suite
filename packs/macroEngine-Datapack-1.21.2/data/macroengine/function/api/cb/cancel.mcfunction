# macroengine:api/cb/cancel
# ─────────────────────────────────────────────────────────────────
# Clears all pending delayed CB commands from the queue.
#
# No input required. Clears the entire queue.
#
# SECURITY: caller must hold macroengine.perm_level >= security.cmd_min_level.
#
# EXAMPLE:
#   function macroengine:api/cb/cancel
# ─────────────────────────────────────────────────────────────────

# Security gate — see core/internal/security/check_all.
# No-op (always passes) unless flags.experimental.strict_gating is on.
scoreboard players set $cbc_gate macroengine.tmp 1
execute store success score $cbc_gate macroengine.tmp run function macroengine:core/internal/security/check_all {required:"cmd_min_level"}
execute if score $cbc_gate macroengine.tmp matches 0 run return 0

data remove storage macroengine:engine cb_queue
data modify storage macroengine:engine cb_queue set value []
