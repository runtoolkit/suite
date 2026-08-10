# Waypoint'e ışınlanma
$execute as $(target) run tp @s @e[type=minecraft:marker,tag=waypoint_$(id),tag=waypoint,limit=1]
$tellraw $(target) [{"text":"📍 Waypoint'e ışınlandınız!","color":"green"}]
