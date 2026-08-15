# Direct named-parameter API for /stopwatch.
# Parameter order: action, id
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/stopwatch
data remove storage rtwrapper:runtime current.params
