# macro:api/toggle/perm/false — Disable the perm trigger module

execute unless entity @s[tag=macro.admin] run return 0

data modify storage macro:engine modules.perm set value 0b

tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"perm","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"disabled","color":"red"}]
tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"toggle/perm ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"false","color":"red"}]
