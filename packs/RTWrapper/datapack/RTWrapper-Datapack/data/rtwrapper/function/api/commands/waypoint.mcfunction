# Direct named-parameter API for /waypoint.
# Parameter order: action, id, property, value, targets
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/waypoint
data remove storage rtwrapper:runtime current.params
