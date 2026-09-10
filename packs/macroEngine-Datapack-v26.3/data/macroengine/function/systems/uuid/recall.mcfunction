# ============================================================
# macroengine:systems/uuid/recall
# Retrieves UUID string from the cache
#
# KULLANIM:
# data modify storage macroengine:input key set value "benim_anahtarim"
# function macroengine:systems/uuid/recall
#
# INPUT:
# macroengine:input key → key name used with uuid/store
#
# OUTPUT:
# macroengine:input value → UUID hex string
# (value unchanged if key not found)
# ============================================================
function macroengine:core/internal/systems/uuid/recall_read with storage macroengine:input
