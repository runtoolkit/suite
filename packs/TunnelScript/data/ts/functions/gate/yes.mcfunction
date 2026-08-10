# Confirm the currently pending gated action. Only the entity holding the
# tunnelscript_gate_owner tag (set when the gate was requested) may confirm.
execute unless data storage tunnelscript:gate pending run tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"Nothing is pending confirmation.","color":"gray"}]
execute if data storage tunnelscript:gate pending if entity @s[tag=tunnelscript_gate_owner] run function tunnelscript_core:internal/gate/run_pending
execute if data storage tunnelscript:gate pending unless entity @s[tag=tunnelscript_gate_owner] run tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"Only the player who requested this action can confirm it.","color":"red"}]
