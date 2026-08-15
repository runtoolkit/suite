# Direct named-parameter API for /version.
# Parameter order: (none)
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/version
data remove storage rtwrapper:runtime current.params
