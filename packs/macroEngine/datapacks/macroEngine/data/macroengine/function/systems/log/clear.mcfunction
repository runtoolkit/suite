# macroengine:systems/log/clear
# Usage: /function macroengine:systems/log/clear
# Clears the log buffer.
execute unless entity @s[tag=macroengine.admin] run return 0
data remove storage macroengine:engine log_display
scoreboard players set #macroengine.log_count macroengine.tmp 0
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Log buffer cleared.","color":"gray"}]
