# ============================================================
# macroengine:systems/uuid/forget
# Deletes a UUID entry from the cache
#
# KULLANIM:
# data modify storage macroengine:input key set value "benim_anahtarim"
# function macroengine:systems/uuid/forget
#
# INPUT:
# macroengine:input key → name of the key to delete
# ============================================================
function macroengine:core/internal/systems/uuid/forget_key with storage macroengine:input
