execute unless data storage macroengine:engine _mcmd_list[0] run return 0

data modify storage macroengine:engine _mcmd_entry set value {}
data modify storage macroengine:engine _mcmd_entry.current_cmd set from storage macroengine:engine _mcmd_list[0]
data remove storage macroengine:engine _mcmd_list[0]

function macroengine:core/internal/api/cmd/other/multi_cmd/exec_func with storage macroengine:engine _mcmd_entry

function macroengine:core/internal/api/cmd/other/multi_cmd/step_func
