# Runs as the triggering player. Reads the selected value, resets the trigger,
# then routes to the matching public ts: function.
#   1 -> ts:version          6 -> ts:run_function     11 -> ts:run_as
#   2 -> ts:help             7 -> ts:run_functions    12 -> ts:run_after
#   3 -> ts:run              8 -> ts:config/get        13 -> ts:menu
#   4 -> ts:run_command      9 -> ts:config/reset      14 -> ts:menu/close
#   5 -> ts:run_commands    10 -> ts:run_if           15 -> ts:dialog/open_dynamic*
# (* dialog entry exists on the 1.21.6 build only)
execute store result score #sel tunnelscript.vars run scoreboard players get @s tunnelScript.use
scoreboard players set @s tunnelScript.use 0
scoreboard players enable @s tunnelScript.use
execute if score #sel tunnelscript.vars matches 1 run function ts:version
execute if score #sel tunnelscript.vars matches 2 run function ts:help
execute if score #sel tunnelscript.vars matches 3 run function ts:run
execute if score #sel tunnelscript.vars matches 4 run function ts:run_command
execute if score #sel tunnelscript.vars matches 5 run function ts:run_commands
execute if score #sel tunnelscript.vars matches 6 run function ts:run_function
execute if score #sel tunnelscript.vars matches 7 run function ts:run_functions
execute if score #sel tunnelscript.vars matches 8 run function ts:config/get
execute if score #sel tunnelscript.vars matches 9 run function ts:config/reset
execute if score #sel tunnelscript.vars matches 10 run function ts:run_if
execute if score #sel tunnelscript.vars matches 11 run function ts:run_as
execute if score #sel tunnelscript.vars matches 12 run function ts:run_after
execute if score #sel tunnelscript.vars matches 13 run function ts:menu
execute if score #sel tunnelscript.vars matches 14 run function ts:menu/close
