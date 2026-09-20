# macroengine:api/toggle/gui/true — Enable the gui module

execute unless entity @s[tag=macroengine.admin] run return 0

data modify storage macroengine:engine modules.gui set value 1b
tellraw @s {"text":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}

tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"gui","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"enabled","color":"green"}]
