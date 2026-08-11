# Direct named-parameter API for /fillbiome.
# Parameter order: from_pos, to_pos, biome, replace, filter
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/fillbiome
data remove storage rtwrapper:runtime current.params
