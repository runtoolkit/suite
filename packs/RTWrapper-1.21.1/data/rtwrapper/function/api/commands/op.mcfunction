# Direct named-parameter API for /op.
# Parameter order: targets
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/op
data remove storage rtwrapper:runtime current.params
