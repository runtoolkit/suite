# Show current input module state.
scoreboard players set #minecart_count tunnelscript.vars 0
execute as @e[type=command_block_minecart,tag=tunnelscript_input] run scoreboard players add #minecart_count tunnelscript.vars 1
execute store result score #queue_len tunnelscript.vars run data get storage tunnelscript:minecart queue
tellraw @s [{"text":"[TunnelScript] Input minecarts=","color":"aqua"},{"score":{"name":"#minecart_count","objective":"tunnelscript.vars"},"color":"white"},{"text":" queue=","color":"aqua"},{"score":{"name":"#queue_len","objective":"tunnelscript.vars"},"color":"white"},{"text":" paused=","color":"aqua"},{"score":{"name":"#input_paused","objective":"tunnelscript.vars"},"color":"white"},{"text":" silent=","color":"aqua"},{"score":{"name":"#input_silent","objective":"tunnelscript.vars"},"color":"white"}]
tellraw @s [{"text":"captured=","color":"gray"},{"score":{"name":"#input_captured","objective":"tunnelscript.vars"},"color":"white"},{"text":" executed=","color":"gray"},{"score":{"name":"#input_executed","objective":"tunnelscript.vars"},"color":"white"}]
