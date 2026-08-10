# Direct named-parameter API for /debugconfig.
# Parameter order: action, option, value
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/debugconfig
data remove storage rtwrapper:runtime current.params
