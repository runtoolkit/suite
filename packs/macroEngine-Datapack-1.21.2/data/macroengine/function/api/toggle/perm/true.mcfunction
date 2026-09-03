# macroengine:api/toggle/perm/true — Enable the perm trigger module

execute unless entity @s[tag=macroengine.admin] run return 0

data modify storage macroengine:engine modules.perm set value 1b
tellraw @s {"text":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}

tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"perm","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"enabled","color":"green"}]
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"toggle/perm ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"true","color":"green"}]
