# Direct named-parameter API for /tellraw.
# Parameter order: targets, message
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/tellraw
data remove storage rtwrapper:runtime current.params
