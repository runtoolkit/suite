# Direct named-parameter API for /swing.
# Parameter order: target, hand
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/swing
data remove storage rtwrapper:runtime current.params
