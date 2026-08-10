# Show a summary of captured minecart inputs. Full log: storage tunnelscript:minecart log[].
tellraw @s [{"text":"[TunnelScript] Minecart input history","color":"aqua","bold":true}]
execute store result score #hist_len tunnelscript.vars run data get storage tunnelscript:minecart log
tellraw @s [{"text":"Total captured entries: ","color":"gray"},{"score":{"name":"#hist_len","objective":"tunnelscript.vars"},"color":"white"}]
