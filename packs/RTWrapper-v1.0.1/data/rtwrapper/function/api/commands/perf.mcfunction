# Direct named-parameter API for /perf.
# Parameter order: action
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/perf
data remove storage rtwrapper:runtime current.params
