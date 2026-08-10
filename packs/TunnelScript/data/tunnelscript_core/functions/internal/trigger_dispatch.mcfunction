# Runs as the triggering player. Reads the value, resets + re-arms the trigger,
# then routes to a public ts: function.
#   1 version   2 help   3 run   4 run_command   5 run_commands   6 config/get   7 config/reset
#   8 dryrun/status   9 log/show   10 repeat
execute store result score #sel tunnelscript.vars run scoreboard players get @s tunnelScript.use
scoreboard players set @s tunnelScript.use 0
scoreboard players enable @s tunnelScript.use
execute if score #sel tunnelscript.vars matches 1 run function ts:version
execute if score #sel tunnelscript.vars matches 2 run function ts:help
execute if score #sel tunnelscript.vars matches 3 run function ts:run
execute if score #sel tunnelscript.vars matches 4 run function ts:run_command
execute if score #sel tunnelscript.vars matches 5 run function ts:run_commands
execute if score #sel tunnelscript.vars matches 6 run function ts:config/get
execute if score #sel tunnelscript.vars matches 7 run function ts:config/reset
execute if score #sel tunnelscript.vars matches 8 run function ts:dryrun/status
execute if score #sel tunnelscript.vars matches 9 run function ts:log/show
execute if score #sel tunnelscript.vars matches 10 run function ts:repeat
