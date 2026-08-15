# Direct named-parameter API for /function.
# Parameter order: function_id, mode, source, path
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/function
data remove storage rtwrapper:runtime current.params
