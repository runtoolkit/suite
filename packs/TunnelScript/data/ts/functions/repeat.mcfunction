# Re-run the most recently executed command.
# Requires the command log (ts:log/on), because that is what remembers it.
execute unless score #log_enabled tunnelscript.vars matches 1.. run tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"repeat needs the command log: run ","color":"red"},{"text":"function ts:log/on","color":"gray"}]
execute if score #log_enabled tunnelscript.vars matches 1.. unless data storage tunnelscript:log entries[0] run tellraw @s {"text":"[TunnelScript] nothing to repeat yet","color":"yellow"}
execute if score #log_enabled tunnelscript.vars matches 1.. if data storage tunnelscript:log entries[0] run function tunnelscript_core:internal/log_rerun
