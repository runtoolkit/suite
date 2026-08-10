# Save storage tunnelscript:in commands[] into a fixed batch slot (1..9).
# Input: {slot:1,name:"starter",commands:["say hi","give @p apple"]}
scoreboard players set #batch_ok tunnelscript.vars 0
scoreboard players set #batch_slot tunnelscript.vars 0
execute store result score #batch_slot tunnelscript.vars run data get storage tunnelscript:in slot
execute if score #batch_slot tunnelscript.vars matches 1 run data modify storage tunnelscript:batch slots.s1 set value {}
execute if score #batch_slot tunnelscript.vars matches 1 run data modify storage tunnelscript:batch slots.s1.commands set from storage tunnelscript:in commands
execute if score #batch_slot tunnelscript.vars matches 1 if data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s1.name set from storage tunnelscript:in name
execute if score #batch_slot tunnelscript.vars matches 1 unless data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s1.name set value "slot 1"
execute if score #batch_slot tunnelscript.vars matches 1 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 2 run data modify storage tunnelscript:batch slots.s2 set value {}
execute if score #batch_slot tunnelscript.vars matches 2 run data modify storage tunnelscript:batch slots.s2.commands set from storage tunnelscript:in commands
execute if score #batch_slot tunnelscript.vars matches 2 if data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s2.name set from storage tunnelscript:in name
execute if score #batch_slot tunnelscript.vars matches 2 unless data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s2.name set value "slot 2"
execute if score #batch_slot tunnelscript.vars matches 2 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 3 run data modify storage tunnelscript:batch slots.s3 set value {}
execute if score #batch_slot tunnelscript.vars matches 3 run data modify storage tunnelscript:batch slots.s3.commands set from storage tunnelscript:in commands
execute if score #batch_slot tunnelscript.vars matches 3 if data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s3.name set from storage tunnelscript:in name
execute if score #batch_slot tunnelscript.vars matches 3 unless data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s3.name set value "slot 3"
execute if score #batch_slot tunnelscript.vars matches 3 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 4 run data modify storage tunnelscript:batch slots.s4 set value {}
execute if score #batch_slot tunnelscript.vars matches 4 run data modify storage tunnelscript:batch slots.s4.commands set from storage tunnelscript:in commands
execute if score #batch_slot tunnelscript.vars matches 4 if data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s4.name set from storage tunnelscript:in name
execute if score #batch_slot tunnelscript.vars matches 4 unless data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s4.name set value "slot 4"
execute if score #batch_slot tunnelscript.vars matches 4 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 5 run data modify storage tunnelscript:batch slots.s5 set value {}
execute if score #batch_slot tunnelscript.vars matches 5 run data modify storage tunnelscript:batch slots.s5.commands set from storage tunnelscript:in commands
execute if score #batch_slot tunnelscript.vars matches 5 if data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s5.name set from storage tunnelscript:in name
execute if score #batch_slot tunnelscript.vars matches 5 unless data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s5.name set value "slot 5"
execute if score #batch_slot tunnelscript.vars matches 5 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 6 run data modify storage tunnelscript:batch slots.s6 set value {}
execute if score #batch_slot tunnelscript.vars matches 6 run data modify storage tunnelscript:batch slots.s6.commands set from storage tunnelscript:in commands
execute if score #batch_slot tunnelscript.vars matches 6 if data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s6.name set from storage tunnelscript:in name
execute if score #batch_slot tunnelscript.vars matches 6 unless data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s6.name set value "slot 6"
execute if score #batch_slot tunnelscript.vars matches 6 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 7 run data modify storage tunnelscript:batch slots.s7 set value {}
execute if score #batch_slot tunnelscript.vars matches 7 run data modify storage tunnelscript:batch slots.s7.commands set from storage tunnelscript:in commands
execute if score #batch_slot tunnelscript.vars matches 7 if data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s7.name set from storage tunnelscript:in name
execute if score #batch_slot tunnelscript.vars matches 7 unless data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s7.name set value "slot 7"
execute if score #batch_slot tunnelscript.vars matches 7 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 8 run data modify storage tunnelscript:batch slots.s8 set value {}
execute if score #batch_slot tunnelscript.vars matches 8 run data modify storage tunnelscript:batch slots.s8.commands set from storage tunnelscript:in commands
execute if score #batch_slot tunnelscript.vars matches 8 if data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s8.name set from storage tunnelscript:in name
execute if score #batch_slot tunnelscript.vars matches 8 unless data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s8.name set value "slot 8"
execute if score #batch_slot tunnelscript.vars matches 8 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_slot tunnelscript.vars matches 9 run data modify storage tunnelscript:batch slots.s9 set value {}
execute if score #batch_slot tunnelscript.vars matches 9 run data modify storage tunnelscript:batch slots.s9.commands set from storage tunnelscript:in commands
execute if score #batch_slot tunnelscript.vars matches 9 if data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s9.name set from storage tunnelscript:in name
execute if score #batch_slot tunnelscript.vars matches 9 unless data storage tunnelscript:in name run data modify storage tunnelscript:batch slots.s9.name set value "slot 9"
execute if score #batch_slot tunnelscript.vars matches 9 run scoreboard players set #batch_ok tunnelscript.vars 1
execute if score #batch_ok tunnelscript.vars matches 1 run tellraw @s [{"text":"[TunnelScript] saved batch slot ","color":"green"},{"score":{"name":"#batch_slot","objective":"tunnelscript.vars"},"color":"white"}]
execute unless score #batch_ok tunnelscript.vars matches 1 run tellraw @s {"text":"[TunnelScript] batch save failed: use slot 1..9 and provide commands[]","color":"red"}
