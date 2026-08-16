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


data remove storage macroengine:engine cb_queue
data modify storage macroengine:engine cb_queue set value []
