# Direct named-parameter API for /save-on.
# Parameter order: (none)
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/save-on
data remove storage rtwrapper:runtime current.params
