function macroengine:core/lib/process_queue

# CB delay queue — process pending command block executions
execute if data storage macroengine:engine modules{cb:1b} run execute if data storage macroengine:engine cb_queue[0] run function macroengine:core/internal/systems/cb/tick
