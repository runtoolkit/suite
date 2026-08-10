# macro:api/toggle/list
# Prints the enabled/disabled state of all AME modules.
#
# Usage:  function macro:api/toggle/list
# Caller: macro.admin tag required

execute unless entity @s[tag=macro.admin] run return 0

tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"━━━ Module States ━━━━━━━━━━━━━━━","color":"#555555"}]
tellraw @s ["",{"text":" ","color":"#555555"},{"storage":"macro:engine","nbt":"modules","interpret":false,"color":"yellow"}]
tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
