# Direct named-parameter API for /enchant.
# Parameter order: targets, enchantment, level
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/enchant
data remove storage rtwrapper:runtime current.params
