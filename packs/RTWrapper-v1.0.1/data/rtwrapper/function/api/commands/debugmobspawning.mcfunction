# Direct named-parameter API for /debugmobspawning.
# Parameter order: action
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/debugmobspawning
data remove storage rtwrapper:runtime current.params
