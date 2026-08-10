# Cancel the currently pending gated action. Anyone can cancel (safety
# valve in case the requester disconnects) - clears the owner tag from
# everyone so the flow resets cleanly.
execute unless data storage tunnelscript:gate pending run tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"Nothing is pending confirmation.","color":"gray"}]
execute if data storage tunnelscript:gate pending run tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"Cancelled: ","color":"yellow"},{"storage":"tunnelscript:gate","nbt":"pending.label","color":"white"}]
data remove storage tunnelscript:gate pending
tag @a remove tunnelscript_gate_owner
