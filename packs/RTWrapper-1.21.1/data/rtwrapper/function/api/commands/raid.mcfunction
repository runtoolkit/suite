# Direct named-parameter API for /raid.
# Parameter order: action
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/raid
data remove storage rtwrapper:runtime current.params
