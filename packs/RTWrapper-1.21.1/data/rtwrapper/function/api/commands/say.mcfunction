# Direct named-parameter API for /say.
# Parameter order: message
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/say
data remove storage rtwrapper:runtime current.params
