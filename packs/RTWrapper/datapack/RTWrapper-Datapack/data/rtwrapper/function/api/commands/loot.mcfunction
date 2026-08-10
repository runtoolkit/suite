# Direct named-parameter API for /loot.
# Parameter order: action, target, target_slot, source_kind, source, tool
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/loot
data remove storage rtwrapper:runtime current.params
