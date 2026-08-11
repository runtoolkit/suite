# Direct named-parameter API for /spawn_armor_trims.
# Parameter order: target
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/spawn_armor_trims
data remove storage rtwrapper:runtime current.params
