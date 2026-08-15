# Direct named-parameter API for /setidletimeout.
# Parameter order: minutes
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/setidletimeout
data remove storage rtwrapper:runtime current.params
