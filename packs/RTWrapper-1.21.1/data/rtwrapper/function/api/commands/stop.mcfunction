# Direct named-parameter API for /stop.
# Parameter order: (none)
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/stop
data remove storage rtwrapper:runtime current.params
