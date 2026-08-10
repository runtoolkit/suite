# Direct named-parameter API for /spreadplayers.
# Parameter order: center, spread_distance, max_range, height_mode, respect_teams, targets
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/spreadplayers
data remove storage rtwrapper:runtime current.params
