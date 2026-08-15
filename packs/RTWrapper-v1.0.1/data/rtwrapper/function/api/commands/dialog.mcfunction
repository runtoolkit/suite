# Direct named-parameter API for /dialog.
# Parameter order: action, targets, dialog
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/dialog
data remove storage rtwrapper:runtime current.params
