# Direct named-parameter API for /serverpack.
# Parameter order: action, id, url, hash
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/serverpack
data remove storage rtwrapper:runtime current.params
