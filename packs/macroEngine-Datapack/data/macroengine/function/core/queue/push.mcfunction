# macroengine:core/queue/push
# Appends a function call to the rate-limited work queue.
# The engine will execute it at up to work_queue_rate calls/tick.
#
# DIFFERENT from lib/queue_add:
#   lib/queue_add  → delay-based scheduler (run after N ticks)
#   queue/push     → throughput limiter   (process heavy lists without lag spikes)
#
# Input  (macroengine:input queue):
#   fn — fully-qualified function path  e.g. "mypack:do_thing"
#
# Usage:
#   data modify storage macroengine:input queue.fn set value "mypack:do_thing"
#   function macroengine:core/queue/push with storage macroengine:input queue

$data modify storage macroengine:engine work_queue append value {fn:"$(fn)"}
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"queue/push ","color":"aqua"},{"text":"→ ","color":"#555555"},{"text":"$(fn)","color":"white"}]
