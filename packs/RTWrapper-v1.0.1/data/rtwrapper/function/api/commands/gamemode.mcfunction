# Direct named-parameter API for /gamemode.
# Parameter order: gamemode, target
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/gamemode
data remove storage rtwrapper:runtime current.params
