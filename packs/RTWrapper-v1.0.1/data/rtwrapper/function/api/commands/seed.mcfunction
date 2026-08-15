# Direct named-parameter API for /seed.
# Parameter order: (none)
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/seed
data remove storage rtwrapper:runtime current.params
