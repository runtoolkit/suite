# Direct named-parameter API for /team.
# Parameter order: action, team, display_name, option, value, targets
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/team
data remove storage rtwrapper:runtime current.params
