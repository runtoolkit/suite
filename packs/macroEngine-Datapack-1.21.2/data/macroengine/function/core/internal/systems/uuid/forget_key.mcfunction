# ============================================================
# macroengine:systems/uuid/internal/forget_key [MACRO FUNCTION]
# Deletes the specified key from uuid_cache
#
# Call: function macroengine:core/internal/systems/uuid/forget_key with storage macroengine:input
# $(key) = name of the key to delete
# ============================================================
$data remove storage macroengine:engine uuid_cache.$(key)
