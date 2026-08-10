# Direct named-parameter API for /tag.
# Parameter order: targets, action, name
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/tag
data remove storage rtwrapper:runtime current.params
