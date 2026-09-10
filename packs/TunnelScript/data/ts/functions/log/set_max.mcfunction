# Set how many entries the log keeps. Input: storage tunnelscript:in {value:64}
execute store result score #log_max tunnelscript.vars run data get storage tunnelscript:in value
execute if score #log_max tunnelscript.vars matches ..0 run scoreboard players set #log_max tunnelscript.vars 1
# # tellraw @s [{"text":"[TunnelScript] log_max = ","color":"aqua"},{"score":{"name":"#log_max","objective":"tunnelscript.vars"},"color":"white"}]
