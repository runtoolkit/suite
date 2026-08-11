# Direct named-parameter API for /list.
# Parameter order: uuids
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/list
data remove storage rtwrapper:runtime current.params
