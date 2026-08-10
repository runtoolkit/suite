# Spawn a floating menu label at the command position (e.g. run via
# /execute positioned ...). Removes any previous TunnelScript hologram first so
# duplicates never stack. Tagged "tunnelscript_menu" for later selection.
kill @e[type=armor_stand,tag=tunnelscript_menu]
summon armor_stand ~ ~ ~ {Tags:["tunnelscript_menu"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b,CustomNameVisible:1b,CustomName:'[{"text":"TunnelScript ","color":"aqua","bold":true},{"text":"Menu","color":"white"}]'}
