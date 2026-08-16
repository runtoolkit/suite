# macroengine:api/toggle/show
# Module toggle helper.

execute unless entity @s[tag=macroengine.admin] run return 0

tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Module toggle UI is only available in newer Minecraft versions","color":"yellow"}]
tellraw @s ["",{"text":"Direct functions: /function macroengine:api/toggle/<module>/true","color":"gray"}]
tellraw @s ["",{"text":" /function macroengine:api/toggle/<module>/false","color":"gray"}]
