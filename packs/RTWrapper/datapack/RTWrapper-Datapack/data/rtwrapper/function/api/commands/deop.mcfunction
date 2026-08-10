# Direct named-parameter API for /deop.
# Parameter order: targets
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/deop
data remove storage rtwrapper:runtime current.params
