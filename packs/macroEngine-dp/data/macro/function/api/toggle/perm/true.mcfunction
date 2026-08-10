# macro:api/toggle/perm/true — Enable the perm trigger module

execute unless entity @s[tag=macro.admin] run return 0

data modify storage macro:engine modules.perm set value 1b

tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"perm","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"enabled","color":"green"}]
tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"toggle/perm ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"true","color":"green"}]
