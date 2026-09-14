# Print the recorded commands. The log is capped at #log_max entries.
tellraw @s {"text":"[TunnelScript] command log","color":"aqua","bold":true}
execute store result score #log_len tunnelscript.vars run data get storage tunnelscript:log entries
tellraw @s [{"text":"entries=","color":"gray"},{"score":{"name":"#log_len","objective":"tunnelscript.vars"},"color":"white"},{"text":"  cap=","color":"gray"},{"score":{"name":"#log_max","objective":"tunnelscript.vars"},"color":"white"},{"text":"  recording=","color":"gray"},{"score":{"name":"#log_enabled","objective":"tunnelscript.vars"},"color":"white"}]
execute if score #log_len tunnelscript.vars matches 1.. run tellraw @s [{"storage":"tunnelscript:log","nbt":"entries","color":"gray"}]
execute if score #log_len tunnelscript.vars matches 0 run tellraw @s {"text":"(empty)","color":"dark_gray"}
