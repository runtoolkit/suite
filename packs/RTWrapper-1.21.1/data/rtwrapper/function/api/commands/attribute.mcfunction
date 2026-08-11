# Direct named-parameter API for /attribute.
# Parameter order: target, attribute, action, value, modifier_id, modifier_value, modifier_operation
data modify storage rtwrapper:runtime current.params set from storage rtwrapper:api params
function rtwrapper:core/wrappers/internal/attribute
data remove storage rtwrapper:runtime current.params
