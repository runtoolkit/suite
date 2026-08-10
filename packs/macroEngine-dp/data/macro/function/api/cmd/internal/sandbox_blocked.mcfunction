# macro:api/cmd/internal/sandbox_blocked
# Called by cmd/ files when sandbox:1b is active AND command is NOT in allowlist.
# Reads macro:engine _sandbox_cmd (set by caller), logs, notifies, and kicks.
function macro:api/cmd/internal/sandbox_blocked_macro with storage macro:engine {}
