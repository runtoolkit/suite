# Direct named-parameter API for /save-off.
# Parameter order: (none)
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/save-off
data remove storage rtwrapper:runtime current.params
