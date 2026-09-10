# Module toggle guard — skips this module when disabled via macroengine:api/toggle/perm/false
execute unless data storage macroengine:engine {modules:{perm:1b}} run return 0

execute unless data storage macroengine:engine perm_trigger_names[0] run return 0

data modify storage macroengine:engine _pt_names_tmp set from storage macroengine:engine perm_trigger_names
function macroengine:core/internal/api/perm/trigger/tick_step_loop
data remove storage macroengine:engine _pt_names_tmp
