# Direct named-parameter API for /ban-ip.
# Parameter order: target, reason
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/ban-ip
data remove storage rtwrapper:runtime current.params
