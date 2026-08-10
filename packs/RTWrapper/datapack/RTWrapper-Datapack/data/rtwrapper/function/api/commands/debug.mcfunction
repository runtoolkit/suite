# Direct named-parameter API for /debug.
# Parameter order: action, target
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/debug
data remove storage rtwrapper:runtime current.params
