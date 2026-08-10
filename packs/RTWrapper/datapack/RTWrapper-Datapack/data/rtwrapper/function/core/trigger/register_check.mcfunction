# Macro: called with storage rtwrapper:api trigger (fields: objective, action, reset_mode).
# Fails (no-op) if the objective is already registered.
$execute if data storage rtwrapper:triggers registry[{objective:"$(objective)"}] run return fail
function rtwrapper:core/trigger/register_apply with storage rtwrapper:api trigger
