# Direct named-parameter API for /stopsound.
# Parameter order: targets, source, sound
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/stopsound
data remove storage rtwrapper:runtime current.params
