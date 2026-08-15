# Direct named-parameter API for /experience.
# Parameter order: action, targets, amount, unit
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/experience
data remove storage rtwrapper:runtime current.params
