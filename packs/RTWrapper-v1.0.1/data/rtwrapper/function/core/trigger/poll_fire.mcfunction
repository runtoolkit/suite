# Macro: called with storage rtwrapper:runtime trigger_cur (objective, reset_mode, action).
# Executor context (@s) is the player whose trigger fired.
data modify storage rtwrapper:api request set from storage rtwrapper:runtime trigger_cur.action
function rtwrapper:api/run

$execute if data storage rtwrapper:runtime trigger_cur{reset_mode:"value"} run scoreboard players set @s $(objective) 0
$scoreboard players enable @s $(objective)