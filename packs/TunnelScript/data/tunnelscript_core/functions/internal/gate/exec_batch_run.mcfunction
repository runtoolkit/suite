# Load a batch slot (1..9) and immediately run it with ts:run_commands.
# Input: {slot:1}
scoreboard players set #batch_ok tunnelscript.vars 0
scoreboard players set #batch_slot tunnelscript.vars 0
execute store result score #batch_slot tunnelscript.vars run data get storage tunnelscript:in slot
execute if score #batch_slot tunnelscript.vars matches 1 if data storage tunnelscript:batch slots.s1.commands run data modify storage tunnelscript:in commands set from storage tunnelscript:batch slots.s1.commands
execute if score #batch_slot tunnelscript.vars matches 1 if data storage tunnelscript:batch slots.s1.commands run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 2 if data storage tunnelscript:batch slots.s2.commands run data modify storage tunnelscript:in commands set from storage tunnelscript:batch slots.s2.commands
execute if score #batch_slot tunnelscript.vars matches 2 if data storage tunnelscript:batch slots.s2.commands run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 3 if data storage tunnelscript:batch slots.s3.commands run data modify storage tunnelscript:in commands set from storage tunnelscript:batch slots.s3.commands
execute if score #batch_slot tunnelscript.vars matches 3 if data storage tunnelscript:batch slots.s3.commands run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 4 if data storage tunnelscript:batch slots.s4.commands run data modify storage tunnelscript:in commands set from storage tunnelscript:batch slots.s4.commands
execute if score #batch_slot tunnelscript.vars matches 4 if data storage tunnelscript:batch slots.s4.commands run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 5 if data storage tunnelscript:batch slots.s5.commands run data modify storage tunnelscript:in commands set from storage tunnelscript:batch slots.s5.commands
execute if score #batch_slot tunnelscript.vars matches 5 if data storage tunnelscript:batch slots.s5.commands run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 6 if data storage tunnelscript:batch slots.s6.commands run data modify storage tunnelscript:in commands set from storage tunnelscript:batch slots.s6.commands
execute if score #batch_slot tunnelscript.vars matches 6 if data storage tunnelscript:batch slots.s6.commands run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 7 if data storage tunnelscript:batch slots.s7.commands run data modify storage tunnelscript:in commands set from storage tunnelscript:batch slots.s7.commands
execute if score #batch_slot tunnelscript.vars matches 7 if data storage tunnelscript:batch slots.s7.commands run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 8 if data storage tunnelscript:batch slots.s8.commands run data modify storage tunnelscript:in commands set from storage tunnelscript:batch slots.s8.commands
execute if score #batch_slot tunnelscript.vars matches 8 if data storage tunnelscript:batch slots.s8.commands run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 9 if data storage tunnelscript:batch slots.s9.commands run data modify storage tunnelscript:in commands set from storage tunnelscript:batch slots.s9.commands
execute if score #batch_slot tunnelscript.vars matches 9 if data storage tunnelscript:batch slots.s9.commands run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_ok tunnelscript.vars matches 1 run function tunnelscript_core:internal/do_run_commands
execute unless score #batch_ok tunnelscript.vars matches 1 run tellraw @s {"text":"[TunnelScript] batch run failed: slot is empty or invalid","color":"red"}
