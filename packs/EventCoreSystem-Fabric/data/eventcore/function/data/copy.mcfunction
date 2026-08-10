# Bir key'i başka bir key'e kopyala.
# Kullanım: {src:"foo",dst:"bar"}
$data modify storage eventcore:data $(dst) set from storage eventcore:data $(src)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"data.copy","color":"#FFAA00"},{"text":"$(src)","color":"white"},{"text":"→","color":"#AAAAAA"},{"text":"$(dst)","color":"white"}]
