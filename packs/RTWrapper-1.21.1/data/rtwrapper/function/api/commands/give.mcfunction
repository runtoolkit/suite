# Direct named-parameter API for /give.
# Parameter order: target, item, count
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/give
data remove storage rtwrapper:runtime current.params
