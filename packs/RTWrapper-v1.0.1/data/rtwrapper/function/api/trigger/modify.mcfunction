# Modify an existing trigger's action and/or reset_mode. No-op if unregistered.
# Required storage keys: trigger.objective (string).
# Optional: trigger.action (compound), trigger.reset_mode ("value"|"keep").
execute unless data storage rtwrapper:api trigger.objective run return fail
function rtwrapper:core/trigger/modify_check with storage rtwrapper:api trigger
data remove storage rtwrapper:api trigger
