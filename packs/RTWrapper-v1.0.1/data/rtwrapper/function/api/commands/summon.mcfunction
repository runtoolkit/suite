# Direct named-parameter API for /summon.
# Parameter order: entity, pos, nbt
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/summon
data remove storage rtwrapper:runtime current.params
