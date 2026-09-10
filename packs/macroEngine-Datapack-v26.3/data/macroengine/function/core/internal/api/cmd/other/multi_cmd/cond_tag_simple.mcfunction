# macroengine:api/cmd/other/multi_cmd/internal/cond_tag_simple
# Simple string tag check

data modify storage macroengine:engine _mcmd_cond_tmp set value {}
data modify storage macroengine:engine _mcmd_cond_tmp.tag set from storage macroengine:engine _mcmd_current.condition.tag
function macroengine:core/internal/api/cmd/other/multi_cmd/cond_tag_exec with storage macroengine:engine _mcmd_cond_tmp
data remove storage macroengine:engine _mcmd_cond_tmp
