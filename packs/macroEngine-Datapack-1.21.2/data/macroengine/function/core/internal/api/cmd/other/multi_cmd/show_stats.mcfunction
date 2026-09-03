# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/other/multi_cmd/internal/show_stats
# Show statistics
# ─────────────────────────────────────────────────────────────────

execute store result score $mcmd_end_time macroengine.tmp run time query gametime
execute store result score $mcmd_duration macroengine.tmp run data get storage macroengine:engine _mcmd_stats.start_time
scoreboard players operation $mcmd_duration macroengine.tmp = $mcmd_end_time macroengine.tmp
scoreboard players operation $mcmd_duration macroengine.tmp -= $mcmd_duration macroengine.tmp

execute store result storage macroengine:engine _mcmd_stats.total int 1 run scoreboard players get $mcmd_total macroengine.tmp
execute store result storage macroengine:engine _mcmd_stats.success int 1 run scoreboard players get $mcmd_success macroengine.tmp
execute store result storage macroengine:engine _mcmd_stats.duration int 1 run scoreboard players get $mcmd_duration macroengine.tmp

tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/stats ","color":"aqua"},{"text":"Total: ","color":"#555555"},{"nbt":"_mcmd_stats.total","plain":true ,"storage":"macroengine:engine","color":"white"},{"text":" | Success: ","color":"#555555"},{"nbt":"_mcmd_stats.success","plain":true ,"storage":"macroengine:engine","color":"green"},{"text":" | Duration: ","color":"#555555"},{"nbt":"_mcmd_stats.duration","plain":true ,"storage":"macroengine:engine","color":"yellow"},{"text":"t","color":"yellow"}]

scoreboard players reset $mcmd_total macroengine.tmp
scoreboard players reset $mcmd_success macroengine.tmp
scoreboard players reset $mcmd_duration macroengine.tmp
scoreboard players reset $mcmd_end_time macroengine.tmp
data remove storage macroengine:engine _mcmd_stats
