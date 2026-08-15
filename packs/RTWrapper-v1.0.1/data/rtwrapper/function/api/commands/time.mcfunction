# Direct named-parameter API for /time.
# Parameter order: action, value
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/time
data remove storage rtwrapper:runtime current.params
