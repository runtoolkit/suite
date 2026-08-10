# Record every command the runner executes into storage tunnelscript:log entries[].
scoreboard players set #log_enabled tunnelscript.vars 1
tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"command log ON","color":"green"}]
