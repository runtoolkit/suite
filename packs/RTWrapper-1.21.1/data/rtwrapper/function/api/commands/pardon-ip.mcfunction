# Direct named-parameter API for /pardon-ip.
# Parameter order: target
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/pardon-ip
data remove storage rtwrapper:runtime current.params
