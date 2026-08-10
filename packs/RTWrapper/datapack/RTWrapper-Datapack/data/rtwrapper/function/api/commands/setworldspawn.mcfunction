# Direct named-parameter API for /setworldspawn.
# Parameter order: pos, angle
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/setworldspawn
data remove storage rtwrapper:runtime current.params
