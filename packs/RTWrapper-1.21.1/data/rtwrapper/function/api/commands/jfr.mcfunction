# Direct named-parameter API for /jfr.
# Parameter order: action
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/jfr
data remove storage rtwrapper:runtime current.params
