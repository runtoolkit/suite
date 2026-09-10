# ============================================================
# macroengine:systems/uuid/store
# Caches @s entity's UUID as both string and int array
#
# KULLANIM:
# data modify storage macroengine:input key set value "benim_anahtarim"
# execute as <entity> run function macroengine:systems/uuid/store
#
# INPUT:
# macroengine:input key → storage key name (e.g. "spawn_point_owner")
#
# OUTPUT (macroengine:engine uuid_cache.<key>):
# .str → UUID hex string
# .arr → UUID int array [I; a, b, c, d]
#
# Not available in GU — an advanced AME-specific function.
# ============================================================

# Build UUID string → macroengine:input value
function macroengine:systems/uuid/from_entity

# Also save array form (from_entity already filled _work)
data modify storage macroengine:uuid _store_arr set from storage macroengine:uuid _work

# Write both to cache (get key name via macro)
function macroengine:core/internal/systems/uuid/store_write with storage macroengine:input
