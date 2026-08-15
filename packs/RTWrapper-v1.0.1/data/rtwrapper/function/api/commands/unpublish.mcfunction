# Direct named-parameter API for /unpublish.
# Parameter order: (none)
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/unpublish
data remove storage rtwrapper:runtime current.params
