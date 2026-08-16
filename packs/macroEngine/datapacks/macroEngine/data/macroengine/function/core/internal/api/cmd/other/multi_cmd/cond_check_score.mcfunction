# Score checker
execute store result score $mcmd_cond_score macroengine.tmp run scoreboard players get @s dummy
data modify storage macroengine:engine _mcmd_cond_tmp set from storage macroengine:engine _mcmd_current.condition.score
function macroengine:core/internal/api/cmd/other/multi_cmd/cond_score_exec with storage macroengine:engine _mcmd_cond_tmp
data remove storage macroengine:engine _mcmd_cond_tmp
scoreboard players reset $mcmd_cond_score macroengine.tmp
