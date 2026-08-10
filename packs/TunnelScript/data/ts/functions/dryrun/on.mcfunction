# Preview mode: every command that reaches the runner is printed instead of
# executed. Nothing is placed, no forceload is taken, the world is untouched.
scoreboard players set #dryrun tunnelscript.vars 1
tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"dry-run ON","color":"gold"},{"text":" - commands are previewed, not executed","color":"gray"}]
