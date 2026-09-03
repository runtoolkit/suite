# macroengine:experimental/crafting_ui/show
# Prints a clickable "custom crafting" shortcut menu.
#
# Usage:  function macroengine:experimental/crafting_ui/show
# Caller: any player

execute unless data storage macroengine:engine flags.experimental{crafting_ui:1b} run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"experimental/crafting_ui is disabled.","color":"red"}]
execute unless data storage macroengine:engine flags.experimental{crafting_ui:1b} run return 0

tellraw @s ["",{"text":"═══════ ","color":"dark_gray"},{"text":"macroEngine — Custom Recipes","color":"aqua","bold":true},{"text":" ═══════","color":"dark_gray"}]
tellraw @s ["",{"text":"Recipes not shown in the vanilla grid. Click to attempt a craft (consumes ingredients if you have them).","color":"gray","italic":true}]
tellraw @s ["",{"text":"[Craft] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function macroengine:experimental/crafting_ui/craft {recipe:\"example\"}"},"hoverEvent":{"action":"show_text","value":"Needs: 2x iron_ingot + 1x stick → 1x shears"}},{"text":"example — 2 iron_ingot + 1 stick → shears","color":"white"}]
tellraw @s ["",{"text":"═════════════════════════════════════","color":"dark_gray"}]
