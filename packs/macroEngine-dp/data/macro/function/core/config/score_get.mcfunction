# macro:core/config/score_get
# Prints a config value to the caller (admin only, debug use).
# Usage: $function macro:core/config/score_get {key:"damage"}
execute unless entity @s[tag=macro.admin] run return 0
$tellraw @s ["",{"text":"[Config] ","color":"aqua"},{"text":"#$(key)","color":"white"},{"text":" = ","color":"#555555"},{"score":{"name":"#$(key)","objective":"macro.config"},"color":"green"}]
