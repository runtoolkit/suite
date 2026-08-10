# Direct named-parameter API for /teammsg.
# Parameter order: message
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/teammsg
data remove storage rtwrapper:runtime current.params
