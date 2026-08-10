# Leave preview mode; commands execute normally again.
scoreboard players set #dryrun tunnelscript.vars 0
tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"dry-run OFF","color":"green"},{"text":" - commands execute normally","color":"gray"}]
