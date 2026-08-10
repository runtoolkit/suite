# Requests a confirmation gate for one dangerous action.
# Caller must set storage tunnelscript_core:gatework req.action (string id)
# and req.label (chat-facing description) before calling this.
# Sets #gate_ok (tunnelscript.vars) to 1 if the request was accepted
# (no other gate pending), 0 if it was rejected (another gate already
# pending - caller should tell the player to resolve or wait it out).
scoreboard players set #gate_ok tunnelscript.vars 0
execute unless data storage tunnelscript:gate pending run scoreboard players set #gate_ok tunnelscript.vars 1
execute if score #gate_ok tunnelscript.vars matches 1 run data modify storage tunnelscript:gate pending set value {}
execute if score #gate_ok tunnelscript.vars matches 1 run data modify storage tunnelscript:gate pending.action set from storage tunnelscript_core:gatework req.action
execute if score #gate_ok tunnelscript.vars matches 1 run data modify storage tunnelscript:gate pending.label set from storage tunnelscript_core:gatework req.label
execute if score #gate_ok tunnelscript.vars matches 1 run data modify storage tunnelscript:gate pending.commands set from storage tunnelscript_core:gatework req.commands
execute if score #gate_ok tunnelscript.vars matches 1 store result storage tunnelscript:gate pending.requested_tick int 1 run time query gametime
execute if score #gate_ok tunnelscript.vars matches 1 run tag @s add tunnelscript_gate_owner
execute if score #gate_ok tunnelscript.vars matches 1 run tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"Confirmation required: ","color":"yellow"},{"storage":"tunnelscript:gate","nbt":"pending.label","color":"white"}]
execute if score #gate_ok tunnelscript.vars matches 1 run tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"Run ","color":"gray"},{"text":"/function ts:gate/yes","color":"green","clickEvent":{"action":"run_command","value":"/function ts:gate/yes"}},{"text":" to confirm or ","color":"gray"},{"text":"/function ts:gate/cancel","color":"red","clickEvent":{"action":"run_command","value":"/function ts:gate/cancel"}},{"text":" to cancel. Expires in 30s.","color":"gray"}]
execute if score #gate_ok tunnelscript.vars matches 0 run tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"Another confirmation is already pending: ","color":"red"},{"storage":"tunnelscript:gate","nbt":"pending.label","color":"white"},{"text":" - resolve it first (","color":"gray"},{"text":"/function ts:gate/yes","color":"green"},{"text":" or ","color":"gray"},{"text":"/function ts:gate/cancel","color":"red"},{"text":")","color":"gray"}]
