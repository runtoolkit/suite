# Set the max actions processed per run (safety cap).
# Input: storage tunnelscript:in { "value": 256 }
execute store result score #max_actions tunnelscript.vars run data get storage tunnelscript:in value
tellraw @s [{"text":"[TunnelScript] max_actions = ","color":"aqua"},{"score":{"name":"#max_actions","objective":"tunnelscript.vars"},"color":"white"}]
