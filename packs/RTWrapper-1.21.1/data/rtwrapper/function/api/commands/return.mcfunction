# Direct named-parameter API for /return.
# Parameter order: mode, value, command
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/return
data remove storage rtwrapper:runtime current.params
