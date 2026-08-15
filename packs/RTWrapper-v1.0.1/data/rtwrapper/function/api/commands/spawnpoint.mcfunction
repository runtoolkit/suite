# Direct named-parameter API for /spawnpoint.
# Parameter order: targets, pos, angle
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/spawnpoint
data remove storage rtwrapper:runtime current.params
