# Direct named-parameter API for /random.
# Parameter order: action, range, sequence
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/random
data remove storage rtwrapper:runtime current.params
