# macroengine:systems/cb/internal/tick
# Called each tick when cb_queue is non-empty.
# Processes all entries: decrements ticks_left, fires those that reach 0.

# Copy queue to work buffer, clear queue, rebuild after processing
data modify storage macroengine:engine _cb_work set from storage macroengine:engine cb_queue
data remove storage macroengine:engine cb_queue
data modify storage macroengine:engine cb_queue set value []

execute if data storage macroengine:engine _cb_work[0] run function macroengine:core/internal/systems/cb/process_step
data remove storage macroengine:engine _cb_work
