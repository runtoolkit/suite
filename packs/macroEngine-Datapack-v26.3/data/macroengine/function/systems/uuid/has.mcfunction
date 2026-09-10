# ============================================================
# macroengine:systems/uuid/has
# Checks whether the specified key exists in the cache
#
# EXAMPLE:
# data modify storage macroengine:input key set value "my_key"
# execute if score $result macroengine.tmp matches 1 ...
# function macroengine:systems/uuid/has
#
# INPUT:
# macroengine:input key → name of the key to check
#
# OUTPUT:
# $uuid.has macroengine.tmp → 1 (found) or 0 (not found)
# ============================================================
scoreboard players set $uuid.has macroengine.tmp 0
function macroengine:core/internal/systems/uuid/has_check with storage macroengine:input
