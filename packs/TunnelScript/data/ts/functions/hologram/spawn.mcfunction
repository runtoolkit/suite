# Spawn a floating menu label at the command position. Kills any previous one.
kill @e[type=armor_stand,tag=tunnelscript_menu]
summon armor_stand ~ ~ ~ {Tags:["tunnelscript_menu"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b,CustomNameVisible:1b,CustomName:'[{"text":"TunnelScript ","color":"aqua","bold":true},{"text":"Menu","color":"white"}]'}
