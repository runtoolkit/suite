# Direct named-parameter API for /tick.
# Parameter order: action, value
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/tick
data remove storage rtwrapper:runtime current.params
