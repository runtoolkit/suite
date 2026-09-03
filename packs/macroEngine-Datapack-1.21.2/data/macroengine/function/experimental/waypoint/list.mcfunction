# macroengine:experimental/waypoint/list
# Prints all stored waypoint names.
#
# Usage:  function macroengine:experimental/waypoint/list
# Caller: any player

execute unless data storage macroengine:engine flags.experimental{waypoint:1b} run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"experimental/waypoint is disabled.","color":"red"}]
execute unless data storage macroengine:engine flags.experimental{waypoint:1b} run return 0

tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━ Waypoints ━━━━━━━━━━━━━━━","color":"#555555"}]
execute unless data storage macroengine:engine waypoints run tellraw @s ["",{"text":"  (none set)","color":"gray","italic":true}]
tellraw @s ["",{"text":" ","color":"#555555"},{"plain":true,"storage":"macroengine:engine","nbt":"waypoints","interpret":false,"color":"yellow"}]
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
