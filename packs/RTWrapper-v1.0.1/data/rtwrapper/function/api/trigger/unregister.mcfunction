# Unregister a trigger. Removes the registry entry only - the scoreboard objective itself
# is left in place (vanilla has no clean way to remove an objective's data mid-session
# without affecting player scores unexpectedly; operators can `/scoreboard objectives
# remove <obj>` manually if desired).
# Required storage keys: trigger.objective (string).
execute unless data storage rtwrapper:api trigger.objective run return fail
function rtwrapper:core/trigger/unregister_apply with storage rtwrapper:api trigger
data remove storage rtwrapper:api trigger
