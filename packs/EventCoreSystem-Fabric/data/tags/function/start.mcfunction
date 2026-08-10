summon minecraft:interaction ~ ~ ~ {Tags:["ec.init"],CustomName:{"text":" EC ","color":"green"}}
execute as @e[type=minecraft:interaction,tag=ec.init] at @s run say Loading...
scoreboard objectives add ec.sys dummy
function eventcore:config/load
function eventcore:version/announce
execute if data storage eventcore:config on_load{enabled:1} run function eventcore:config/run_on_load
kill @e[type=minecraft:interaction,tag=ec.init]
