# macroengine:core/queue/size
# Writes the current work_queue item count to macroengine:output queue.size.
# No macro input required.
#
# Output (macroengine:output queue):
# size — int number of pending items
#
# Usage:
# function macroengine:core/queue/size
# data get storage macroengine:output queue.size

execute store result storage macroengine:output queue.size int 1 run data get storage macroengine:engine work_queue
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"queue/size ","color":"aqua"},{"text":"→ ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"queue.size","color":"yellow"}]
