# Macro: called with storage rtwrapper:runtime trigger_poll (field: index, an int).
# Processes registry[index] for the current player context (@s), then hands off to
# poll_next to check/recurse on index+1.
$data modify storage rtwrapper:runtime trigger_cur set from storage rtwrapper:triggers registry[$(index)]
function rtwrapper:core/trigger/poll_check with storage rtwrapper:runtime trigger_cur
data remove storage rtwrapper:runtime trigger_cur

$scoreboard players set #idx rtw.status $(index)
scoreboard players add #idx rtw.status 1
execute store result storage rtwrapper:runtime trigger_poll.index int 1 run scoreboard players get #idx rtw.status
function rtwrapper:core/trigger/poll_next with storage rtwrapper:runtime trigger_poll
