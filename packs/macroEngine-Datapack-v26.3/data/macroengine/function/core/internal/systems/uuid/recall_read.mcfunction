# ============================================================
# macroengine:systems/uuid/internal/recall_read [MACRO FUNCTION]
# Reads UUID string from the cache
#
# Call: function macroengine:core/internal/systems/uuid/recall_read with storage macroengine:input
# $(key) = key name
# ============================================================
$data modify storage macroengine:input value set from storage macroengine:engine uuid_cache.$(key).str
