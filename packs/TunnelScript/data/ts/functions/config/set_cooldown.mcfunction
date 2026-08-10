# Set the run cooldown in game ticks (0 disables it).
# Input: storage tunnelscript:in { "ticks": 20 }
execute store result score #cooldown_max tunnelscript.vars run data get storage tunnelscript:in ticks
tellraw @s [{"text":"[TunnelScript] cooldown = ","color":"aqua"},{"score":{"name":"#cooldown_max","objective":"tunnelscript.vars"},"color":"white"},{"text":" ticks","color":"gray"}]
