# Macro: called with storage rtwrapper:api trigger (fields: objective, reset_mode).
$data modify storage rtwrapper:triggers registry[{objective:"$(objective)"}].reset_mode set from storage rtwrapper:api trigger.reset_mode
