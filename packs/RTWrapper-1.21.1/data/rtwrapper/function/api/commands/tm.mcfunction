# Direct named-parameter API for /tm.
# Parameter order: message
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/tm
data remove storage rtwrapper:runtime current.params
