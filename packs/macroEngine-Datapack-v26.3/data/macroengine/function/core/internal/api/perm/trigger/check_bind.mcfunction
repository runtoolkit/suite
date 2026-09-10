execute unless data storage macroengine:engine _ptd_binds[0] run return 0

data modify storage macroengine:engine _ptd_current set from storage macroengine:engine _ptd_binds[0]
data remove storage macroengine:engine _ptd_binds[0]

execute store result score $ptd_entry_val macroengine.tmp run data get storage macroengine:engine _ptd_current.value
execute if score $ptd_val macroengine.tmp = $ptd_entry_val macroengine.tmp run function macroengine:core/internal/api/perm/trigger/run_if_perm with storage macroengine:engine _ptd_current

function macroengine:core/internal/api/perm/trigger/check_bind
