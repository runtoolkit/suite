$execute as $(target) at @s run summon minecraft:marker ~ ~ ~ {CustomName:$(name),Tags:["waypoint","waypoint_$(id)"],Marker:1b}
$tellraw $(target) [{"text":"📍 Waypoint oluşturuldu: ","color":"green"},{"text":"$(id)","color":"aqua"}]
