# macroengine:systems/hook/internal/unbind_filter
# Iterates over the _hook_unbinds list.
# Copies back binds that do not match _hook_filter_event to hook_binds.

execute unless data storage macroengine:engine _hook_unbinds[0] run return 0

data modify storage macroengine:engine _hook_unbinds[0] set from storage macroengine:engine _hook_unbinds[0]

function macroengine:core/internal/systems/hook/unbind_check with storage macroengine:engine _hook_unbinds[0]

data remove storage macroengine:engine _hook_unbinds[0]

function macroengine:core/internal/systems/hook/unbind_filter
