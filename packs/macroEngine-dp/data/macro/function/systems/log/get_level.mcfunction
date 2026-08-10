# macro:systems/log/get_level
# Usage: /function macro:systems/log/get_level
# Shows the current log level.
tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"Log level: ","color":"gray"},{"score":{"name":"#ame.log_level","objective":"ame.log_level"},"color":"white","bold":true},{"text":"  (0=off 1=error 2=warn 3=info 4=debug)","color":"#555555"}]
