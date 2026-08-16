# macroengine:api/toggle/wand/false — Disable the wand module

execute unless entity @s[tag=macroengine.admin] run return 0

data modify storage macroengine:engine modules.wand set value 0b

tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"wand","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"disabled","color":"red"}]
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"toggle/wand ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"false","color":"red"}]
