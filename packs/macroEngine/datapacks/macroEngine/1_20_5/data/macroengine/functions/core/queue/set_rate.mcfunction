# macroengine:core/queue/set_rate
# Sets how many work_queue items are processed per tick.
# Default: 1. Raise for faster throughput; lower to reduce tick cost.
# A value of 0 pauses processing.
#
# Input (macroengine:input queue):
# rate — integer ≥ 0
#
# Usage:
# data modify storage macroengine:input queue.rate set value 4
# function macroengine:core/queue/set_rate with storage macroengine:input queue

$data modify storage macroengine:engine work_queue_rate set value $(rate)
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"queue/set_rate ","color":"aqua"},{"text":"→ ","color":"#555555"},{"text":"$(rate)","color":"yellow"},{"text":" items/tick","color":"#555555"}]
