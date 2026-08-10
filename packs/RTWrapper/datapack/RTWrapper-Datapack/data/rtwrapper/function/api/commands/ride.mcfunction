# Direct named-parameter API for /ride.
# Parameter order: target, action, vehicle
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/ride
data remove storage rtwrapper:runtime current.params
