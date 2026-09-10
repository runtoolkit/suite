# macroengine:api/wand/internal/dispatch
# Called as @s. Compare held items with the bind list.

data modify storage macroengine:engine _wand_iter set from storage macroengine:engine wand_binds
execute if data storage macroengine:engine _wand_iter[0] run function macroengine:core/internal/api/wand/check_next
data remove storage macroengine:engine _wand_iter
data remove storage macroengine:engine _wand_current
