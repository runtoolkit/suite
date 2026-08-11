# Direct named-parameter API for /damage.
# Parameter order: target, amount, damage_type, location_or_by, source, cause
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/damage
data remove storage rtwrapper:runtime current.params
