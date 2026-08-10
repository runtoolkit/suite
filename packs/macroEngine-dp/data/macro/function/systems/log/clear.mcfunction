# macro:systems/log/clear
# Usage: /function macro:systems/log/clear
# Clears the log buffer.
execute unless entity @s[tag=macro.admin] run return 0
data remove storage macro:engine log_display
scoreboard players set #ame.log_count macro.tmp 0
tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"Log buffer cleared.","color":"gray"}]
