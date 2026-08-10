# Direct named-parameter API for /me.
# Parameter order: message
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/me
data remove storage rtwrapper:runtime current.params
