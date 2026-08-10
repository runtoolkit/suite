# Runs as the selecting player. Reads the chosen option, resets and re-arms the
# trigger, then routes to the matching public ts: function. The menu stays open.
# The "open menu" option is omitted here (you are already in it), so the high
# values are: 10 run_if, 11 run_as, 12 run_after, 13 menu/close, 14 dialog*.
# (* dialog entry exists on the 1.21.6 build only)
execute store result score #sel tunnelscript.vars run scoreboard players get @s tunnelScript.menu
scoreboard players set @s tunnelScript.menu 0
execute if entity @s[tag=tsMenuOpen] run scoreboard players enable @s tunnelScript.menu
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
execute if score #sel tunnelscript.vars matches 13 run function ts:menu/close
