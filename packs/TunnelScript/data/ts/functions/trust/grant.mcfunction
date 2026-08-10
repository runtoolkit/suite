# Grant the calling entity permission to use the gated dangerous actions
# (run_command, run_commands, batch/run, batch/delete, and the input/log/
# dryrun reset & clear commands). Intended to be run by an operator, e.g.:
#   /execute as <player> run function ts:trust/grant
tag @s add tunnelscript.trusted
tellraw @s ["",{"text":"[TunnelScript] ","color":"aqua"},{"text":"Granted: you can now request gated actions.","color":"green"}]
