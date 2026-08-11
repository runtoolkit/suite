# Direct named-parameter API for /ban.
# Parameter order: target, reason
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/ban
data remove storage rtwrapper:runtime current.params
