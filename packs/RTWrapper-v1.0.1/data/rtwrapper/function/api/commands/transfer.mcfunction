# Direct named-parameter API for /transfer.
# Parameter order: hostname, port, players
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/transfer
data remove storage rtwrapper:runtime current.params
