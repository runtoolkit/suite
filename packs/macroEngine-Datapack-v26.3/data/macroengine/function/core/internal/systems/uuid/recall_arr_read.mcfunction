# ============================================================
# macroengine:systems/uuid/internal/recall_arr_read [MACRO FUNCTION]
# Reads UUID int array from the cache
#
# Call: function macroengine:core/internal/systems/uuid/recall_arr_read with storage macroengine:input
# $(key) = key name
# ============================================================
$data modify storage macroengine:input value set from storage macroengine:engine uuid_cache.$(key).arr
