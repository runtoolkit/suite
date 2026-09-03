# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/other/multi_cmd/advanced/internal/run_spread_tick
# Called once per tick by `schedule` to process the next spread command.
# Self-schedules until _mcmd_queue is drained.
# ─────────────────────────────────────────────────────────────────

execute unless data storage macroengine:engine _mcmd_queue[0] run return 0

data modify storage macroengine:engine _mcmd_current set from storage macroengine:engine _mcmd_queue[0]
data remove storage macroengine:engine _mcmd_queue[0]

execute if data storage macroengine:engine _mcmd_current{} run function macroengine:core/internal/api/cmd/other/multi_cmd/exec_object
execute unless data storage macroengine:engine _mcmd_current{} run function macroengine:core/internal/api/cmd/other/multi_cmd/exec_string

data remove storage macroengine:engine _mcmd_current

# Continue draining the queue — schedule next tick
execute if data storage macroengine:engine _mcmd_queue[0] run schedule function macroengine:core/internal/api/cmd/other/multi_cmd/advanced/run_spread_tick 1t append

# Cleanup options when fully done
execute unless data storage macroengine:engine _mcmd_queue[0] run data remove storage macroengine:engine _mcmd_options

tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"multi_cmd/spread ","color":"aqua"},{"text":"◉ tick","color":"#555555"}]
