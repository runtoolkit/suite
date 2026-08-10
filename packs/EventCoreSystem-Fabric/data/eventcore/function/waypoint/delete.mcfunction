$kill @e[type=minecraft:marker,tag=waypoint_$(id),tag=waypoint,limit=1]
$tellraw $(target) [{"text":"📍 Waypoint silindi!","color":"red"}]
