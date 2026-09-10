# macroengine:experimental/crafting_ui/show
# Prints a clickable "custom crafting" shortcut menu.
#
# Usage:  function macroengine:experimental/crafting_ui/show
# Caller: any player

# # execute unless data storage macroengine:engine flags.experimental{crafting_ui:1b} run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"experimental/crafting_ui is disabled.","color":"red"}]
execute unless data storage macroengine:engine flags.experimental{crafting_ui:1b} run return 0

# # tellraw @s ["",{"text":"═══════ ","color":"dark_gray"},{"text":"macroEngine — Custom Recipes","color":"aqua","bold":true},{"text":" ═══════","color":"dark_gray"}]
tellraw @s ["",{"text":"Recipes not shown in the vanilla grid. Click to attempt a craft (consumes ingredients if you have them).","color":"gray","italic":true}]
function #macroengine:cui/list_recipes
tellraw @s ["",{"text":"═════════════════════════════════════","color":"dark_gray"}]
