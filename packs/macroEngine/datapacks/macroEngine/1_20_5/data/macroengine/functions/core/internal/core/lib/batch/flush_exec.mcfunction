# macroengine:core/lib/batch/internal/flush_exec [MACRO]
# INPUT: $(id)
# For each item, delay = floor(idx * spread_over / total) is computed.
# Item'lar tek tek process_queue'ya eklenir — slice storage gerekmez.

$execute unless data storage macroengine:engine batches.$(id) run return 0

# Load total and spread_over values to score
$execute store result score $bfl_total macroengine.tmp run data get storage macroengine:engine batches.$(id).items
$execute store result score $bfl_spread macroengine.tmp run data get storage macroengine:engine batches.$(id).spread_over
execute if score $bfl_spread macroengine.tmp matches ..0 run scoreboard players set $bfl_spread macroengine.tmp 1
execute if score $bfl_total macroengine.tmp matches 0 run return 0

# Iteration counter
scoreboard players set $bfl_idx macroengine.tmp 0

# Copy items to working storage
$data modify storage macroengine:engine _bfl_items set from storage macroengine:engine batches.$(id).items
$data modify storage macroengine:engine _bfl_id set value "$(id)"

function macroengine:core/internal/core/lib/batch/flush_loop

data remove storage macroengine:engine _bfl_items
data remove storage macroengine:engine _bfl_id
scoreboard players reset $bfl_idx macroengine.tmp
scoreboard players reset $bfl_total macroengine.tmp
scoreboard players reset $bfl_spread macroengine.tmp

$data remove storage macroengine:engine batches.$(id)

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/batch/flush ","color":"aqua"},{"text":"$(id)","color":"white"},{"text":" — queued","color":"green"}]
