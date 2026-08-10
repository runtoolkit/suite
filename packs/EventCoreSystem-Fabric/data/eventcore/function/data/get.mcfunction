# Değeri eventcore:sys data_result'e kopyala.
# Kullanım: {key:"foo"}
$data modify storage eventcore:sys data_result set from storage eventcore:data $(key)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"data.get","color":"#FFAA00"},{"text":"key=","color":"#AAAAAA"},{"text":"$(key)","color":"white"},{"text":" → sys.data_result","color":"#AAAAAA"}]
