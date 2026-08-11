# Direct named-parameter API for /recipe.
# Parameter order: action, targets, recipe
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/recipe
data remove storage rtwrapper:runtime current.params
