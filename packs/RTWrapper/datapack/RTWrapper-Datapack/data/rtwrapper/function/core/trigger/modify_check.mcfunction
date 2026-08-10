# Macro: called with storage rtwrapper:api trigger (fields: objective, optional action,
# optional reset_mode). Fails (no-op) if the objective is not registered.
$execute unless data storage rtwrapper:triggers registry[{objective:"$(objective)"}] run return fail

execute if data storage rtwrapper:api trigger.action run function rtwrapper:core/trigger/modify_action with storage rtwrapper:api trigger
execute if data storage rtwrapper:api trigger.reset_mode run function rtwrapper:core/trigger/modify_reset_mode with storage rtwrapper:api trigger
