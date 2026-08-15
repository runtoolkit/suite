# Direct named-parameter API for /w.
# Parameter order: target, message
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/w
data remove storage rtwrapper:runtime current.params
