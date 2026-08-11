# Direct named-parameter API for /data.
# Parameter order: action, target_kind, target, path, operation, source_kind, source, source_path, value
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/data
data remove storage rtwrapper:runtime current.params
