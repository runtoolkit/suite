# Direct named-parameter API for /whitelist.
# Parameter order: action, target
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/whitelist
data remove storage rtwrapper:runtime current.params
