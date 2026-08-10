# Direct named-parameter API for /save-all.
# Parameter order: flush
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/save-all
data remove storage rtwrapper:runtime current.params
