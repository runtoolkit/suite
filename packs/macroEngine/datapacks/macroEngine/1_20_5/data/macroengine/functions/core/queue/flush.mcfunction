# macroengine:core/queue/flush
# Processes ALL remaining work_queue items in a single tick.
# WARNING: large queues will cause a lag spike. Use only when you know
# the queue is small (< ~50 items) or in a controlled context.
# No macro input required.
#
# Usage:
# function macroengine:core/queue/flush

execute if data storage macroengine:engine work_queue[0] run function macroengine:core/internal/core/queue/flush_loop
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"queue/flush ","color":"aqua"},{"text":"→ done","color":"green"}]
