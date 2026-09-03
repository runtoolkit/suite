# macroengine:api/toggle/interaction/false — Disable the interaction (IE) module

execute unless entity @s[tag=macroengine.admin] run return 0

data modify storage macroengine:engine modules.interaction set value 0b
tellraw @s {"text":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}

tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"interaction","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"disabled","color":"red"}]
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"toggle/interaction ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"false","color":"red"}]
