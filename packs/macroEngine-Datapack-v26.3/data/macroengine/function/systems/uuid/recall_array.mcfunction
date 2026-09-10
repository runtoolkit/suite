# ============================================================
# macroengine:systems/uuid/recall_array
# Retrieves UUID int array from the cache
#
# KULLANIM:
# data modify storage macroengine:input key set value "benim_anahtarim"
# function macroengine:systems/uuid/recall_array
#
# INPUT:
# macroengine:input key → key name used with uuid/store
#
# OUTPUT:
# macroengine:input value → UUID int array [I; a, b, c, d]
# (value unchanged if key not found)
#
# Use case: writing UUID to entity NBT (e.g. Owner field)
# ============================================================
function macroengine:core/internal/systems/uuid/recall_arr_read with storage macroengine:input
