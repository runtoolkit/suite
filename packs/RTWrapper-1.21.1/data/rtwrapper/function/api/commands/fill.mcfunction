# Direct named-parameter API for /fill.
# Parameter order: from_pos, to_pos, block, mode, filter
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/fill
data remove storage rtwrapper:runtime current.params
