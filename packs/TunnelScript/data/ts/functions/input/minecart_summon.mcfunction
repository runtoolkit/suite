# Summon a command-block minecart input source at the caller's position.
kill @e[type=command_block_minecart,tag=tunnelscript_input,limit=1,sort=nearest]
summon minecraft:command_block_minecart ~ ~ ~ {Tags:["tunnelscript_input"],TrackOutput:1b,NoGravity:1b,Invulnerable:1b,Silent:1b,Command:""}
tellraw @s [{"text":"[TunnelScript] Input minecart summoned. Its Command will be read automatically.","color":"aqua"}]
