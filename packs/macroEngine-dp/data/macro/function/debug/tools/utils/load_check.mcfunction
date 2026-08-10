# macro:debug/tools/utils/load_check
# Returns 1 if engine is loaded, 0 (+ fallback) if not.
execute if data storage macro:engine global{loaded:1b} run return 1
function macro:core/fallback/not_loaded
return 0
