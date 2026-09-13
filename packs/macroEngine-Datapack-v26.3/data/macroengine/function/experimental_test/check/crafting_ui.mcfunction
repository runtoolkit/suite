# macroengine:experimental_test/check/crafting_ui [INTERNAL]
# Only checks that the loader runs and produces a (possibly empty)
# recipes compound. NOTE: as shipped, #macroengine:cui/load_recipes
# is an empty tag ("values": []) — recipes.mcfunction's own comment
# claims "example recipe included so the shortcut in show.mcfunction
# has something to actually craft", but no such recipe exists in this
# build. This check can only confirm the loader itself doesn't error;
# it does NOT verify an example recipe is present, because there
# isn't one. Flagging this mismatch rather than silently signaling
# accept on a false premise.

data modify storage macroengine:engine flags.experimental.crafting_ui set value 1b

function macroengine:experimental/crafting_ui/recipes
execute unless data storage macroengine:engine _crafting_ui.recipes run function macroengine:experimental_test/signal {result:"fail"}
execute if data storage macroengine:engine _crafting_ui.recipes run function macroengine:experimental_test/signal {result:"accept"}

data modify storage macroengine:engine flags.experimental.crafting_ui set value 0b
