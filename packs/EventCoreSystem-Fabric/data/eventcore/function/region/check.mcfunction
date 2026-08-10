# Bölgedeki varlıklara fonksiyon çalıştır.
# Kullanım: {x:0,y:64,z:0,dx:10,dy:10,dz:10,func:"ns:path",selector:"@a"}
# dx/dy/dz = bölge boyutu (x2-x1 gibi)
$execute as $(selector)[x=$(x),y=$(y),z=$(z),dx=$(dx),dy=$(dy),dz=$(dz)] at @s run function $(func)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"region.check","color":"#FFAA00"},{"text":"func=","color":"#AAAAAA"},{"text":"$(func)","color":"white"}]
