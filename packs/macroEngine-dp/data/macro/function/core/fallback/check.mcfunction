# macro:core/fallback/check
# Returns 1 if a fallback was triggered in the last call, 0 otherwise.
# Usage:
#   function macro:core/fallback/clear
#   function ns:your/action
#   execute if data storage macro:output fallback{triggered:1b} run function ns:handle_failure
#   function macro:core/fallback/check   ← or use this for return-based checks
execute if data storage macro:output fallback{triggered:1b} run return 1
return 0
