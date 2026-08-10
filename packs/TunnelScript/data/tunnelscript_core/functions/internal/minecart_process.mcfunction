# Called as the minecart. Empty Command means no change, so exit silently.
data modify storage tunnelscript:minecart current set from entity @s Command
execute unless data storage tunnelscript:minecart {current:""} run function tunnelscript_core:internal/minecart_capture
