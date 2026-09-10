# ─────────────────────────────────────────────────────────────────
# macroengine:core/lib/batch/add
# Adds a job to the batch queue.
#
# INPUT (storage macroengine:input):
# id → batch id
# func → function to run (opsiyonel)
# cmd → command to run (optional, used if no func)
# ─────────────────────────────────────────────────────────────────

function macroengine:core/internal/core/lib/batch/add_exec with storage macroengine:input {}
