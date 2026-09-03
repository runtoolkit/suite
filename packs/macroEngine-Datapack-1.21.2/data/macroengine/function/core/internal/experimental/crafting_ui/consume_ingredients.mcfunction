# macroengine:core/internal/experimental/crafting_ui/consume_ingredients [MACRO]
# Called `with storage macroengine:engine _crafting_ui.active` AFTER
# check_ingredients has already confirmed every ingredient is present —
# this file does not re-check, only removes. Recursive pop-front,
# same convention as check_ingredients.mcfunction.

execute unless data storage macroengine:engine _crafting_ui.active.ingredients[0] run return 0

data modify storage macroengine:engine _cui_ing set from storage macroengine:engine _crafting_ui.active.ingredients[0]
data remove storage macroengine:engine _crafting_ui.active.ingredients[0]

function macroengine:core/internal/experimental/crafting_ui/consume_one_ingredient with storage macroengine:engine _cui_ing
data remove storage macroengine:engine _cui_ing

execute if data storage macroengine:engine _crafting_ui.active.ingredients[0] run function macroengine:core/internal/experimental/crafting_ui/consume_ingredients with storage macroengine:engine _crafting_ui.active
