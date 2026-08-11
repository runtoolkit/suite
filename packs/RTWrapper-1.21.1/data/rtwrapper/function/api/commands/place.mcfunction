# Direct named-parameter API for /place.
# Parameter order: type, id, pos, rotation, mirror, integrity, seed
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/place
data remove storage rtwrapper:runtime current.params
