# Direct named-parameter API for /trigger.
# Parameter order: objective, action, value
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/trigger
data remove storage rtwrapper:runtime current.params
