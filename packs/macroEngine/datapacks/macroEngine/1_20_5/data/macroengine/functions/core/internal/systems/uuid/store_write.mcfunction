# ============================================================
# macroengine:systems/uuid/internal/store_write [MACRO FUNCTION]
# UUID'yi macroengine:engine uuid_cache'e yazar (hem string hem array)
#
# Call: function macroengine:core/internal/systems/uuid/store_write with storage macroengine:input
# $(key) = key name
# $(value) = UUID hex string (written by from_entity)
# ============================================================
$data modify storage macroengine:engine uuid_cache.$(key).str set value "$(value)"
$data modify storage macroengine:engine uuid_cache.$(key).arr set from storage macroengine:uuid _store_arr
