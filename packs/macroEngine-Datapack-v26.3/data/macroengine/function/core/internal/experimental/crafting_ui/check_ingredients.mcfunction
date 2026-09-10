# macroengine:core/internal/experimental/crafting_ui/check_ingredients [MACRO]
# Called `with storage macroengine:engine _crafting_ui.active`.
# Walks a COPY of ingredients (`_cui_check`) so active.ingredients
# stays intact for consume_ingredients afterwards.

execute unless data storage macroengine:engine _cui_check run data modify storage macroengine:engine _cui_check set from storage macroengine:engine _crafting_ui.active.ingredients

execute unless data storage macroengine:engine _cui_check[0] run return 0

data modify storage macroengine:engine _cui_ing set from storage macroengine:engine _cui_check[0]
data remove storage macroengine:engine _cui_check[0]

function macroengine:core/internal/experimental/crafting_ui/check_one_ingredient with storage macroengine:engine _cui_ing
data remove storage macroengine:engine _cui_ing

# Continue only while list remains AND we have not already failed.
execute if data storage macroengine:engine _crafting_ui{ok:1b} if data storage macroengine:engine _cui_check[0] run function macroengine:core/internal/experimental/crafting_ui/check_ingredients with storage macroengine:engine _crafting_ui.active
