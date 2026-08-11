# Direct named-parameter API for /pardon.
# Parameter order: targets
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/pardon
data remove storage rtwrapper:runtime current.params
