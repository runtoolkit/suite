# macroengine:experimental/crafting_ui/recipes [INTERNAL]
# Recipe definitions for experimental/crafting_ui. Each recipe is a
# compound under _crafting_ui.recipes.<id> with:
#   ingredients (list of {item, count})
#   result      {item, count}
#
# Edit/add recipes here — this is the single source of truth, read by
# experimental/crafting_ui/craft.mcfunction. Example recipe included
# so the shortcut in show.mcfunction has something to actually craft.

execute unless data storage macroengine:engine _crafting_ui run data modify storage macroengine:engine _crafting_ui set value {}
data modify storage macroengine:engine _crafting_ui.recipes set value {}

function #macroengine:cui/load_recipes