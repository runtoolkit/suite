# Direct named-parameter API for /warden_spawn_tracker.
# Parameter order: target
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/warden_spawn_tracker
data remove storage rtwrapper:runtime current.params
