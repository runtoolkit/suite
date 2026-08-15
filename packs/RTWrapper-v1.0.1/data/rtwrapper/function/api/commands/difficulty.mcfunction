# Direct named-parameter API for /difficulty.
# Parameter order: difficulty
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/difficulty
data remove storage rtwrapper:runtime current.params
