# Direct named-parameter API for /datapack.
# Parameter order: action, name, position, anchor
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/datapack
data remove storage rtwrapper:runtime current.params
