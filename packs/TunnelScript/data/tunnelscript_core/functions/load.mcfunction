# TunnelScript 1.1.0 - bootstrap (Minecraft 1.19.2)
# 1.19.2 has no function macros, so dynamic commands run through a command block
# (see tunnelscript_core:internal/run_block). Static features work normally.
execute as @a at @s run tellraw @s [{"text":"[TS]","color":"aqua"}," ",{"text":"Loading TunnelScript...","color":"yellow"}]

scoreboard objectives add tunnelscript.vars dummy
scoreboard objectives add tunnelScript.use trigger
execute unless score #max_actions tunnelscript.vars = #max_actions tunnelscript.vars run scoreboard players set #max_actions tunnelscript.vars 256
execute unless score #cooldown_max tunnelscript.vars = #cooldown_max tunnelscript.vars run scoreboard players set #cooldown_max tunnelscript.vars 0
execute unless score #last_run tunnelscript.vars = #last_run tunnelscript.vars run scoreboard players set #last_run tunnelscript.vars -2000000000
scoreboard players set #neg_one tunnelscript.vars -1
# Minecart input storage init.
execute unless data storage tunnelscript:minecart queue run data modify storage tunnelscript:minecart queue set value []
execute unless data storage tunnelscript:minecart log run data modify storage tunnelscript:minecart log set value []
execute unless score #input_paused tunnelscript.vars = #input_paused tunnelscript.vars run scoreboard players set #input_paused tunnelscript.vars 0
execute unless score #input_silent tunnelscript.vars = #input_silent tunnelscript.vars run scoreboard players set #input_silent tunnelscript.vars 0
execute unless score #input_captured tunnelscript.vars = #input_captured tunnelscript.vars run scoreboard players set #input_captured tunnelscript.vars 0
execute unless score #input_executed tunnelscript.vars = #input_executed tunnelscript.vars run scoreboard players set #input_executed tunnelscript.vars 0
# Dry-run, command log and repeat state.
execute unless score #dryrun tunnelscript.vars = #dryrun tunnelscript.vars run scoreboard players set #dryrun tunnelscript.vars 0
execute unless score #dryrun_count tunnelscript.vars = #dryrun_count tunnelscript.vars run scoreboard players set #dryrun_count tunnelscript.vars 0
execute unless score #log_enabled tunnelscript.vars = #log_enabled tunnelscript.vars run scoreboard players set #log_enabled tunnelscript.vars 0
execute unless score #log_max tunnelscript.vars = #log_max tunnelscript.vars run scoreboard players set #log_max tunnelscript.vars 64
execute unless data storage tunnelscript:log entries run data modify storage tunnelscript:log entries set value []
# Confirmation gate init (does not clear an in-progress pending gate across reloads).
tag @a remove tunnelscript_gate_owner
data remove storage tunnelscript:gate pending
# Publish version + config to storage so other packs can read it.
data modify storage tunnelscript:meta version set value "1.1.0"
data modify storage tunnelscript:meta target set value "Minecraft 1.19.2"

execute as @a at @s run tellraw @s [{"text":"[TS]","color":"aqua"}," ",{"text":"Loaded TunnelScript!","color":"green"}]
