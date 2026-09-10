# macroengine:api/wand/internal/unbind_filter
# Write back entries from _wand_unbinds that do not match _wand_filter_tag.

execute unless data storage macroengine:engine _wand_unbinds[0] run return 0

data modify storage macroengine:engine _wand_cur set from storage macroengine:engine _wand_unbinds[0]
data remove storage macroengine:engine _wand_unbinds[0]

function macroengine:core/internal/api/wand/unbind_check with storage macroengine:engine _wand_cur

function macroengine:core/internal/api/wand/unbind_filter
data remove storage macroengine:engine _wand_cur
