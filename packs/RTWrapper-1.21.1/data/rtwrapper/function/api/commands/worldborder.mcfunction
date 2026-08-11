# Direct named-parameter API for /worldborder.
# Parameter order: action, value, time
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/worldborder
data remove storage rtwrapper:runtime current.params
