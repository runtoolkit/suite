# Macro: called with storage rtwrapper:api trigger (fields: objective, action).
$data modify storage rtwrapper:triggers registry[{objective:"$(objective)"}].action set from storage rtwrapper:api trigger.action
