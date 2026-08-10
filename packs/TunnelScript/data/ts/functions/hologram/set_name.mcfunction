# Relabel the hologram from storage tunnelscript:in { "name": <JSON text> }.
# Provide a JSON text component, e.g. '[{"text":"Shop","color":"gold"}]'.
data modify entity @e[type=armor_stand,tag=tunnelscript_menu,limit=1] CustomName set from storage tunnelscript:in name
