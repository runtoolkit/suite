# Direct named-parameter API for /msg.
# Parameter order: target, message
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/msg
data remove storage rtwrapper:runtime current.params
