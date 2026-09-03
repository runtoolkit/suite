# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/other/multi_cmd/run
# Execute queued commands
# ─────────────────────────────────────────────────────────────────

# Reset statistics
execute if data storage macroengine:engine _mcmd_options{profile:1b} run data modify storage macroengine:engine _mcmd_stats set value {total:0,success:0,failed:0,start_time:0}
execute if data storage macroengine:engine _mcmd_options{profile:1b} run execute store result storage macroengine:engine _mcmd_stats.start_time int 1 run time query gametime

# Start recursive stepping
function macroengine:core/internal/api/cmd/other/multi_cmd/step

# Cleanup
function macroengine:core/internal/api/cmd/other/multi_cmd/cleanup

# Show statistics
execute if data storage macroengine:engine _mcmd_options{profile:1b} run function macroengine:core/internal/api/cmd/other/multi_cmd/show_stats

tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/run ","color":"aqua"},{"text":"✔ batch done","color":"green"}]
