# macro:api/cmd/internal/sandbox_gate
# Allowlist-aware sandbox gate for cmd/ functions.
# Called by sandbox-guarded cmd/ files instead of the old sandbox_blocked pattern.
#
# Returns 1 → command is allowlisted — execution continues.
# Returns 0 → command is blocked + player kicked — execution halts.
#
# Requires: macro:engine _sandbox_cmd to be set by caller.
# Caller pattern:
#   execute if data storage macro:engine {sandbox:1b} run data modify storage macro:engine _sandbox_cmd set value "cmdname"
#   execute if data storage macro:engine {sandbox:1b} run execute unless function macro:api/cmd/internal/sandbox_gate run return 0
function macro:api/cmd/internal/sandbox_gate_macro with storage macro:engine {}
