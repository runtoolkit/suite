# Register a new custom /trigger command backed by RTWrapper.
# Required storage keys: trigger.objective (string), trigger.action (compound - RTWrapper
#   request shape, e.g. {cmd:"say", params:{message:"hi"}}).
# Optional: trigger.reset_mode ("value"|"keep", default "value" - whether the trigger score
#   is reset to 0 after firing like vanilla `trigger <obj> set 0`, or left as-is for "keep").
#
# No-ops (does not duplicate) if the objective is already registered - use
# rtwrapper:api/trigger/modify to change an existing registration.
execute unless data storage rtwrapper:api trigger.objective run return fail
execute unless data storage rtwrapper:api trigger.action run return fail
execute unless data storage rtwrapper:api trigger.reset_mode run data modify storage rtwrapper:api trigger.reset_mode set value "value"

function rtwrapper:core/trigger/register_check with storage rtwrapper:api trigger
data remove storage rtwrapper:api trigger
