# macroengine:api/toggle/gui/false — Disable the gui module
#
# Closes every open menu BEFORE flipping the flag. gui/core/tick returns immediately when the module is
# off, so nothing would ever dispose an open menu's cart entity / reset its scores afterwards
# (orphaned carts stay in the world until the next /reload sweep).

execute unless entity @s[tag=macroengine.admin] run return 0

execute as @a[scores={macroengine.gui_uid=1..}] at @s run function macroengine:gui/api/close

data modify storage macroengine:engine modules.gui set value 0b
tellraw @s {"text":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}

tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"gui","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"disabled","color":"red"}]
