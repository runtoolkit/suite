# macroengine:api/toggle/geo/true — Enable the geo/region_watch module

execute unless entity @s[tag=macroengine.admin] run return 0

data modify storage macroengine:engine modules.geo set value 1b

tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"geo","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"enabled","color":"green"}]
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"toggle/geo ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"true","color":"green"}]
