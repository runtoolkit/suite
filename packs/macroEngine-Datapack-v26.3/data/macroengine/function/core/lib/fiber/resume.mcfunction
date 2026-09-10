# ─────────────────────────────────────────────────────────────────
# macroengine:core/lib/fiber/resume
# Resumes a fiber immediately (no delay).
# Used to trigger a fiber step externally without yield.
#
# INPUT (storage macroengine:input):
# id → fiber id
# func → function to run
# ─────────────────────────────────────────────────────────────────

function macroengine:core/internal/core/lib/fiber/resume_exec with storage macroengine:input {}
