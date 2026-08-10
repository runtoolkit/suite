# Dry-run: report the command instead of executing it. No block is placed and
# no forceload is taken, so a preview cannot touch the world at all.
scoreboard players add #dryrun_count tunnelscript.vars 1
tellraw @a [{"text":"[TS/dry] ","color":"gold"},{"storage":"tunnelscript:in","nbt":"cmd","color":"white"}]
