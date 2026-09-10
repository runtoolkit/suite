# macroengine:api/wand/internal/check_next
# Iterate bind list: match the tag of the held item.

execute unless data storage macroengine:engine _wand_iter[0] run return 0

data modify storage macroengine:engine _wand_current set from storage macroengine:engine _wand_iter[0]
data remove storage macroengine:engine _wand_iter[0]

function macroengine:core/internal/api/wand/check_item with storage macroengine:engine _wand_current

function macroengine:core/internal/api/wand/check_next
