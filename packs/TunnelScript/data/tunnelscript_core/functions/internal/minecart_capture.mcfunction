# Save first, clear input, then queue execution and fire callbacks.
scoreboard players add #input_captured tunnelscript.vars 1
data modify storage tunnelscript:minecart last_captured set from storage tunnelscript:minecart current
data modify storage tunnelscript:minecart log append from storage tunnelscript:minecart current
data modify storage tunnelscript:minecart queue append from storage tunnelscript:minecart current
data modify entity @s Command set value ""
execute unless score #input_silent tunnelscript.vars matches 1.. run tellraw @p [{"text":"[TunnelScript] Input captured and queued","color":"aqua"}]
execute as @s run function #ts:input
