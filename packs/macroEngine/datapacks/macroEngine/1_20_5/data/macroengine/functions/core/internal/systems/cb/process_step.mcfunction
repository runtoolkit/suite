# macroengine:systems/cb/internal/process_step
# Pops first entry from _cb_work.
# ticks_left == 1 → fire now.
# ticks_left > 1 → decrement and return to cb_queue.

# Pop first entry
data modify storage macroengine:engine _cb_entry set from storage macroengine:engine _cb_work[0]
data remove storage macroengine:engine _cb_work[0]

# Decrement ticks_left
execute store result score #cb_tl macroengine.tmp run data get storage macroengine:engine _cb_entry.ticks_left
scoreboard players remove #cb_tl macroengine.tmp 1

execute if score #cb_tl macroengine.tmp matches ..0 run function macroengine:core/internal/systems/cb/fire_entry

execute unless score #cb_tl macroengine.tmp matches ..0 run execute store result storage macroengine:engine _cb_entry.ticks_left int 1 run scoreboard players get #cb_tl macroengine.tmp
execute unless score #cb_tl macroengine.tmp matches ..0 run data modify storage macroengine:engine cb_queue append from storage macroengine:engine _cb_entry

data remove storage macroengine:engine _cb_entry

# Recurse if more entries remain
execute if data storage macroengine:engine _cb_work[0] run function macroengine:core/internal/systems/cb/process_step
