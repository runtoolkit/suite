execute unless data storage macroengine:engine _pt_unbind[0] run return 0

execute store result score $pt_fval macroengine.tmp run data get storage macroengine:engine _pt_unbind[0].value
execute store result score $pt_uval macroengine.tmp run data get storage macroengine:engine _pt_uval

execute unless score $pt_fval macroengine.tmp = $pt_uval macroengine.tmp run function macroengine:core/internal/api/perm/trigger/unbind_reinsert with storage macroengine:engine _pt_filter_ctx

data remove storage macroengine:engine _pt_unbind[0]
function macroengine:core/internal/api/perm/trigger/unbind_filter
