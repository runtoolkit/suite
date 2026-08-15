# Direct named-parameter API for /bossbar.
# Parameter order: action, id, name, property, value, players
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/bossbar
data remove storage rtwrapper:runtime current.params
