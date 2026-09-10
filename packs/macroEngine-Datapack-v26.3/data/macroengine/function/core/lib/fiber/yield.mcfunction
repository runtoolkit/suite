# ─────────────────────────────────────────────────────────────────
# macroengine:core/lib/fiber/yield
# Exits a fiber step and queues the next step.
# Checks if the fiber is dead — no resume after kill.
#
# INPUT (storage macroengine:input):
# id → fiber id
# resume → function name of the next step
# delay → how many ticks to wait before resuming (default: 1)
#
# CALL SITE: called at the end of a fiber step function.
# ─────────────────────────────────────────────────────────────────

function macroengine:core/internal/core/lib/fiber/yield_exec with storage macroengine:input {}
