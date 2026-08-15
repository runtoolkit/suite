# Direct named-parameter API for /kill.
# Parameter order: targets
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/kill
data remove storage rtwrapper:runtime current.params
