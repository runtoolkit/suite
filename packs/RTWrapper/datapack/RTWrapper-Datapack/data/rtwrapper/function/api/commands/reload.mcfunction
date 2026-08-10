# Direct named-parameter API for /reload.
# Parameter order: (none)
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/reload
data remove storage rtwrapper:runtime current.params
