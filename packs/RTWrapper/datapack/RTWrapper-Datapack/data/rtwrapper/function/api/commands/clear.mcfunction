# Direct named-parameter API for /clear.
# Parameter order: targets, item, max_count
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/clear
data remove storage rtwrapper:runtime current.params
