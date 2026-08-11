# Direct named-parameter API for /banlist.
# Parameter order: filter
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/banlist
data remove storage rtwrapper:runtime current.params
