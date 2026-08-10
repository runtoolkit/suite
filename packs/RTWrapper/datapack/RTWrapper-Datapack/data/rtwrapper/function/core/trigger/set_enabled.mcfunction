# Macro: called with storage rtwrapper:api trigger (fields: objective, optional enabled).
# If "enabled" is absent, defaults to 1b (this is what api/trigger/enable.mcfunction relies
# on - it does not set the field itself). api/trigger/disable.mcfunction sets it to 0b before
# calling this. No-ops if the objective is not registered.
$execute unless data storage rtwrapper:triggers registry[{objective:"$(objective)"}] run return fail
execute unless data storage rtwrapper:api trigger.enabled run data modify storage rtwrapper:api trigger.enabled set value 1b
$data modify storage rtwrapper:triggers registry[{objective:"$(objective)"}].enabled set from storage rtwrapper:api trigger.enabled
