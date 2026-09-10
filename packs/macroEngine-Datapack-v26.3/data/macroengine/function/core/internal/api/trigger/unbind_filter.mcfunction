execute unless data storage macroengine:engine _tc_unbind[0] run return 0

execute store result score $tc_fval macroengine.tmp run data get storage macroengine:engine _tc_unbind[0].value

execute store result score $tc_uval macroengine.tmp run data get storage macroengine:engine _tc_uval

execute unless score $tc_fval macroengine.tmp = $tc_uval macroengine.tmp run data modify storage macroengine:engine trigger_binds append from storage macroengine:engine _tc_unbind[0]

data remove storage macroengine:engine _tc_unbind[0]
function macroengine:core/internal/api/trigger/unbind_filter
