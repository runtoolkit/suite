# macroengine:core/queue/clear
# Discards all pending work_queue items immediately.
# No macro input required.
#
# Usage:
#   function macroengine:core/queue/clear

data modify storage macroengine:engine work_queue set value []
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"queue/clear ","color":"aqua"},{"text":"→ work_queue emptied","color":"#555555"}]
