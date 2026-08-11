# Direct named-parameter API for /forceload.
# Parameter order: action, from_pos, to_pos
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/forceload
data remove storage rtwrapper:runtime current.params
