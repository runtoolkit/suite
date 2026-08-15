# Direct named-parameter API for /scoreboard.
# Parameter order: category, action, subject, objective, value, operation, source, source_objective
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/scoreboard
data remove storage rtwrapper:runtime current.params
