# Direct named-parameter API for /schedule.
# Parameter order: action, function_id, time, mode
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/schedule
data remove storage rtwrapper:runtime current.params
