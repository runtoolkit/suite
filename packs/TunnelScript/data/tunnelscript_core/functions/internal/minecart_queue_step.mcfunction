# Pop and execute one queued command.
scoreboard players add #input_executed tunnelscript.vars 1
data modify storage tunnelscript:in cmd set from storage tunnelscript:minecart queue[0]
data modify storage tunnelscript:minecart last_executed set from storage tunnelscript:minecart queue[0]
data remove storage tunnelscript:minecart queue[0]
function tunnelscript_core:internal/run_block
execute unless score #input_silent tunnelscript.vars matches 1.. run tellraw @a [{"text":"[TunnelScript] Executing queued input","color":"green"}]
