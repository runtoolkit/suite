# Load a batch slot (1..9) and immediately run it with ts:run_commands.
# Input: {slot:1}
# Requires the tunnelscript.trusted tag, and requires confirmation
# (ts:gate/yes / ts:gate/cancel) before it actually runs.
execute unless entity @s[tag=tunnelscript.trusted] run tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"You don't have permission for this action (requires the tunnelscript.trusted tag).","color":"red"}]
execute if entity @s[tag=tunnelscript.trusted] run data modify storage tunnelscript_core:gatework req set value {}
execute if entity @s[tag=tunnelscript.trusted] run data modify storage tunnelscript_core:gatework req.action set value "batch_run"
execute if entity @s[tag=tunnelscript.trusted] run data modify storage tunnelscript_core:gatework req.label set value "run a saved batch slot"
execute if entity @s[tag=tunnelscript.trusted] run data modify storage tunnelscript_core:gatework req.commands set value {}
execute if entity @s[tag=tunnelscript.trusted] run data modify storage tunnelscript_core:gatework req.commands.slot set from storage tunnelscript:in slot
execute if entity @s[tag=tunnelscript.trusted] run function tunnelscript_core:internal/gate/request
