# Direct named-parameter API for /tp.
# Parameter order: target, x, y, z, rotation, facing_mode, facing_target, facing_anchor
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/tp
data remove storage rtwrapper:runtime current.params
