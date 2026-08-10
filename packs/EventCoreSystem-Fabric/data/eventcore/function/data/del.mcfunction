# Depodan girişi sil.
# Kullanım: {key:"foo"}
$data remove storage eventcore:data $(key)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"data.del","color":"#FFAA00"},{"text":"key=","color":"#AAAAAA"},{"text":"$(key)","color":"white"}]
