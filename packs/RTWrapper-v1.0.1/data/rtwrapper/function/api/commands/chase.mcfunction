# Direct named-parameter API for /chase.
# Parameter order: action, targets
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/chase
data remove storage rtwrapper:runtime current.params
