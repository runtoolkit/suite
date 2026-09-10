# macroengine:core/lib/batch/internal/flush_loop
# Consumes _bfl_items. For each item:
# delay = floor($bfl_idx * $bfl_spread / $bfl_total)
# computed and added to the queue.
# func or cmd presence is checked with execute if data.

execute unless data storage macroengine:engine _bfl_items[0] run return 0

# delay = floor(idx * spread / total)
scoreboard players operation $bfl_delay macroengine.tmp = $bfl_idx macroengine.tmp
scoreboard players operation $bfl_delay macroengine.tmp *= $bfl_spread macroengine.tmp
scoreboard players operation $bfl_delay macroengine.tmp /= $bfl_total macroengine.tmp

# Move item to temporary storage
data modify storage macroengine:engine _bfl_cur set from storage macroengine:engine _bfl_items[0]
data remove storage macroengine:engine _bfl_items[0]

# Write delay to item, then queue by func/cmd
execute store result storage macroengine:engine _bfl_cur.delay int 1 run scoreboard players get $bfl_delay macroengine.tmp

execute if data storage macroengine:engine _bfl_cur.func run function macroengine:core/internal/core/lib/batch/flush_queue_func with storage macroengine:engine _bfl_cur
execute unless data storage macroengine:engine _bfl_cur.func run execute if data storage macroengine:engine _bfl_cur.cmd run function macroengine:core/internal/core/lib/batch/flush_queue_cmd with storage macroengine:engine _bfl_cur

data remove storage macroengine:engine _bfl_cur
scoreboard players add $bfl_idx macroengine.tmp 1

function macroengine:core/internal/core/lib/batch/flush_loop