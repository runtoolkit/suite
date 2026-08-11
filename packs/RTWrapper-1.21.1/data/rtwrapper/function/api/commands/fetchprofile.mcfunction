# Direct named-parameter API for /fetchprofile.
# Parameter order: name
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/fetchprofile
data remove storage rtwrapper:runtime current.params
