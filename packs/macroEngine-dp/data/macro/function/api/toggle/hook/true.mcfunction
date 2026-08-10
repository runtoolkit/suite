# macro:api/toggle/hook/true — Enable the hook module
# Called by the module toggle dialog when State = true.
# Caller: macro.admin tag required (enforced by dialog show guard in show.mcfunction)

execute unless entity @s[tag=macro.admin] run return 0

data modify storage macro:engine modules.hook set value 1b

tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"hook","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"enabled","color":"green"}]
tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"toggle/hook ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"true","color":"green"}]
