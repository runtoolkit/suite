# Genel amaçlı anahtar-değer deposuna yaz.
# Kullanım: {key:"foo",value:"bar"}  — value: herhangi NBT türü
$data modify storage eventcore:data $(key) set value $(value)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"data.set","color":"#FFAA00"},{"text":"key=","color":"#AAAAAA"},{"text":"$(key)","color":"white"}]
