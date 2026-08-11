# Direct named-parameter API for /debugpath.
# Parameter order: target
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/debugpath
data remove storage rtwrapper:runtime current.params
