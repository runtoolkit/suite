# Direct named-parameter API for /clone.
# Parameter order: begin, end, destination, mask_mode, clone_mode, filter
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/clone
data remove storage rtwrapper:runtime current.params
