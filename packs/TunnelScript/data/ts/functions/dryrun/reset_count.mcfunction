# Reset the preview counter.
# Requires the tunnelscript.trusted tag, and requires confirmation
# (ts:gate/yes / ts:gate/cancel) before it actually runs.
execute unless entity @s[tag=tunnelscript.trusted] run tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"You don't have permission for this action (requires the tunnelscript.trusted tag).","color":"red"}]
execute if entity @s[tag=tunnelscript.trusted] run data modify storage tunnelscript_core:gatework req set value {}
execute if entity @s[tag=tunnelscript.trusted] run data modify storage tunnelscript_core:gatework req.action set value "dryrun_reset_count"
execute if entity @s[tag=tunnelscript.trusted] run data modify storage tunnelscript_core:gatework req.label set value "reset dry-run counter"
execute if entity @s[tag=tunnelscript.trusted] run data modify storage tunnelscript_core:gatework req.commands set value {}
execute if entity @s[tag=tunnelscript.trusted] run function tunnelscript_core:internal/gate/request
