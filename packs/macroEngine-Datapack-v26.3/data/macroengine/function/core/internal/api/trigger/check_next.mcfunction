execute unless data storage macroengine:engine _tc_binds[0] run return 0

data modify storage macroengine:engine _tc_current set from storage macroengine:engine _tc_binds[0]
data remove storage macroengine:engine _tc_binds[0]

execute store result score $tc_val macroengine.tmp run data get storage macroengine:engine _tc_current.value

execute if score $tc_player macroengine.tmp = $tc_val macroengine.tmp if data storage macroengine:engine _tc_current.func run function macroengine:core/internal/api/trigger/call with storage macroengine:engine _tc_current

execute if score $tc_player macroengine.tmp = $tc_val macroengine.tmp if data storage macroengine:engine _tc_current.cmd run function macroengine:core/internal/api/trigger/call2 with storage macroengine:engine _tc_current

function macroengine:core/internal/api/trigger/check_next
