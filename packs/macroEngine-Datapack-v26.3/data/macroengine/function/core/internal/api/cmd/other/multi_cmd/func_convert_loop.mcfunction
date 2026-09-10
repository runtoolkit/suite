# Convert string list to {func:"..."} objects
execute unless data storage macroengine:input list[0] run return 0

data modify storage macroengine:engine _mcmd_func_tmp set value {}
data modify storage macroengine:engine _mcmd_func_tmp.func set from storage macroengine:input list[0]
data modify storage macroengine:engine _mcmd_queue append from storage macroengine:engine _mcmd_func_tmp

data remove storage macroengine:input list[0]
function macroengine:core/internal/api/cmd/other/multi_cmd/func_convert_loop
