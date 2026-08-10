# Runs every tick from tick.mcfunction. If a gate has been pending for 600+
# ticks (30 real seconds at normal tick rate), auto-cancel it.
scoreboard players set #gate_elapsed tunnelscript.vars 0
execute if data storage tunnelscript:gate pending store result score #gate_now tunnelscript.vars run time query gametime
execute if data storage tunnelscript:gate pending run data modify storage tunnelscript_core:gatework tocheck set from storage tunnelscript:gate pending.requested_tick
execute if data storage tunnelscript:gate pending store result score #gate_requested tunnelscript.vars run data get storage tunnelscript_core:gatework tocheck
execute if data storage tunnelscript:gate pending run scoreboard players operation #gate_elapsed tunnelscript.vars = #gate_now tunnelscript.vars
execute if data storage tunnelscript:gate pending run scoreboard players operation #gate_elapsed tunnelscript.vars -= #gate_requested tunnelscript.vars
execute if data storage tunnelscript:gate pending if score #gate_elapsed tunnelscript.vars matches 600.. run tellraw @a [{"text":"[TunnelScript] ","color":"aqua"},{"text":"Confirmation timed out: ","color":"gray"},{"storage":"tunnelscript:gate","nbt":"pending.label","color":"white"}]
execute if data storage tunnelscript:gate pending if score #gate_elapsed tunnelscript.vars matches 600.. run data remove storage tunnelscript:gate pending
execute if score #gate_elapsed tunnelscript.vars matches 600.. run tag @a remove tunnelscript_gate_owner
