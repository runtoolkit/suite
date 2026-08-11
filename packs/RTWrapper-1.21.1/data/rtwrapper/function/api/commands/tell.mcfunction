# Direct named-parameter API for /tell.
# Parameter order: target, message
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/tell
data remove storage rtwrapper:runtime current.params
