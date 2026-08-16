# macroengine:systems/log/get_level
# Usage: /function macroengine:systems/log/get_level
# Shows the current log level.
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Log level: ","color":"gray"},{"score":{"name":"#macroengine.log_level","objective":"macroengine.log_level"},"color":"white","bold":true},{"text":" (0=off 1=error 2=warn 3=info 4=debug)","color":"#555555"}]
