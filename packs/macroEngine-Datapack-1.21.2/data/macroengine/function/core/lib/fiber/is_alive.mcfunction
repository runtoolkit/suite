# ─────────────────────────────────────────────────────────────────
# macroengine:core/lib/fiber/is_alive
# Checks whether a fiber is active.
#
# INPUT (storage macroengine:input):
# id → fiber id
#
# OUTPUT (storage macroengine:output):
# result → 1b (active) | 0b (dead or never started)
# ─────────────────────────────────────────────────────────────────

function macroengine:core/internal/core/lib/fiber/is_alive_exec with storage macroengine:input {}
