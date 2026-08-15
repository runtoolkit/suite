# Direct named-parameter API for /help.
# Parameter order: command
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/help
data remove storage rtwrapper:runtime current.params
