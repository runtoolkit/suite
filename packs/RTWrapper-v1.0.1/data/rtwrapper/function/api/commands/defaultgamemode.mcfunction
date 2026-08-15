# Direct named-parameter API for /defaultgamemode.
# Parameter order: gamemode
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/defaultgamemode
data remove storage rtwrapper:runtime current.params
