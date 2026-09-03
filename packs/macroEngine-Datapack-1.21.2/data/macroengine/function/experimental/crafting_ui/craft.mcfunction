# macroengine:experimental/crafting_ui/craft [MACRO]
# Usage:  function macroengine:experimental/crafting_ui/craft {recipe:"example"}
# Caller: any player

execute unless data storage macroengine:engine flags.experimental{crafting_ui:1b} run return 0

function macroengine:experimental/crafting_ui/recipes

$execute unless data storage macroengine:engine _crafting_ui.recipes.$(recipe) run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"unknown recipe: ","color":"red"},{"text":"$(recipe)","color":"aqua"}]
$execute unless data storage macroengine:engine _crafting_ui.recipes.$(recipe) run return 0

$data modify storage macroengine:engine _crafting_ui.active set from storage macroengine:engine _crafting_ui.recipes.$(recipe)

# Check every ingredient (all-or-nothing). Uses a working copy so the
# real ingredients list is still available for consume below.
data modify storage macroengine:engine _crafting_ui.ok set value 1b
data remove storage macroengine:engine _cui_check
function macroengine:core/internal/experimental/crafting_ui/check_ingredients with storage macroengine:engine _crafting_ui.active
data remove storage macroengine:engine _cui_check

execute unless data storage macroengine:engine _crafting_ui{ok:1b} run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"missing ingredients.","color":"red"}]
execute unless data storage macroengine:engine _crafting_ui{ok:1b} run data remove storage macroengine:engine _crafting_ui
execute unless data storage macroengine:engine _crafting_ui{ok:1b} run return 0

# All present — consume then give.
function macroengine:core/internal/experimental/crafting_ui/consume_ingredients with storage macroengine:engine _crafting_ui.active
function macroengine:core/internal/experimental/crafting_ui/give_result with storage macroengine:engine _crafting_ui.active.result

tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"crafted!","color":"green"}]
data remove storage macroengine:engine _crafting_ui
