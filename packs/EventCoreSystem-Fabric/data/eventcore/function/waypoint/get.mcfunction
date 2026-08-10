$tellraw @s [{"text":"ID:","color":"aqua"}," ",{entity:"@e[type=minecraft:marker,tag=waypoint_$(id),tag=waypoint,limit=1]",nbt:"Tags[1]","italic":false,"color":"green"}]

$tellraw @s [{"text":"Konum:","color":"aqua"}," ",{entity:"@e[type=minecraft:marker,tag=waypoint_$(id),tag=waypoint,limit=1]",nbt:"Pos","italic":false,"color":"green"},"\n",{"text":"Tag(lar)","color":"aqua"}," ",{entity:"@e[type=minecraft:marker,tag=waypoint_$(id),tag=waypoint,limit=1]",nbt:"Tags"}]
