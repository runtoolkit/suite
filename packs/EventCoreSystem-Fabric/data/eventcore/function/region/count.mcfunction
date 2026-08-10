# Bölgedeki varlık sayısını eventcore:sys region_count int olarak sakla.
# Kullanım: {x:0,y:64,z:0,dx:10,dy:10,dz:10,selector:"@a"}
$execute store result storage eventcore:sys region_count int 1 run execute if entity $(selector)[x=$(x),y=$(y),z=$(z),dx=$(dx),dy=$(dy),dz=$(dz)]
execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"region.count","color":"#FFAA00"},{"text":"→ sys.region_count","color":"#AAAAAA"}]