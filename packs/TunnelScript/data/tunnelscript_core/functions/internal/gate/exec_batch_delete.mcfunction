# Delete a batch slot (1..9). Input: {slot:1}
scoreboard players set #batch_ok tunnelscript.vars 0
scoreboard players set #batch_slot tunnelscript.vars 0
execute store result score #batch_slot tunnelscript.vars run data get storage tunnelscript:in slot
execute if score #batch_slot tunnelscript.vars matches 1 if data storage tunnelscript:batch slots.s1 run data remove storage tunnelscript:batch slots.s1
execute if score #batch_slot tunnelscript.vars matches 1 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 2 if data storage tunnelscript:batch slots.s2 run data remove storage tunnelscript:batch slots.s2
execute if score #batch_slot tunnelscript.vars matches 2 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 3 if data storage tunnelscript:batch slots.s3 run data remove storage tunnelscript:batch slots.s3
execute if score #batch_slot tunnelscript.vars matches 3 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 4 if data storage tunnelscript:batch slots.s4 run data remove storage tunnelscript:batch slots.s4
execute if score #batch_slot tunnelscript.vars matches 4 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 5 if data storage tunnelscript:batch slots.s5 run data remove storage tunnelscript:batch slots.s5
execute if score #batch_slot tunnelscript.vars matches 5 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 6 if data storage tunnelscript:batch slots.s6 run data remove storage tunnelscript:batch slots.s6
execute if score #batch_slot tunnelscript.vars matches 6 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 7 if data storage tunnelscript:batch slots.s7 run data remove storage tunnelscript:batch slots.s7
execute if score #batch_slot tunnelscript.vars matches 7 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 8 if data storage tunnelscript:batch slots.s8 run data remove storage tunnelscript:batch slots.s8
execute if score #batch_slot tunnelscript.vars matches 8 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 9 if data storage tunnelscript:batch slots.s9 run data remove storage tunnelscript:batch slots.s9
execute if score #batch_slot tunnelscript.vars matches 9 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_ok tunnelscript.vars matches 1 run tellraw @s [{"text":"[TunnelScript] deleted batch slot ","color":"green"},{"score":{"name":"#batch_slot","objective":"tunnelscript.vars"},"color":"white"}]
execute unless score #batch_ok tunnelscript.vars matches 1 run tellraw @s {"text":"[TunnelScript] batch delete failed: use slot 1..9","color":"red"}
