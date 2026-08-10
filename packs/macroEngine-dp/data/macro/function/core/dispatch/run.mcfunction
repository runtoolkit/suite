# ─────────────────────────────────────────────────────────────────
# macro:core/dispatch/run
# Central function dispatch gateway — called via #macro:internal/dispatch.
# Reads func from macro:engine._dispatch and calls exec via macro.
#
# Override #macro:internal/dispatch in your overlay/pack to inject
# validation or logging without touching call sites.
# ─────────────────────────────────────────────────────────────────
function macro:core/dispatch/exec with storage macro:engine _dispatch
