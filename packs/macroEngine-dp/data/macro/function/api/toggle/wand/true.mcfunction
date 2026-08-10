# macro:api/toggle/wand/true — Enable the wand module

execute unless entity @s[tag=macro.admin] run return 0

data modify storage macro:engine modules.wand set value 1b

tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"wand","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"enabled","color":"green"}]
tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"toggle/wand ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"true","color":"green"}]
