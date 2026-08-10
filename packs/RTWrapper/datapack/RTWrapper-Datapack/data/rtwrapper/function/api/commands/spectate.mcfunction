# Direct named-parameter API for /spectate.
# Parameter order: target, player
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/spectate
data remove storage rtwrapper:runtime current.params
