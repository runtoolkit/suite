# Flag'ı tamamen sil. Kullanım: {name:"my_flag"}
$data remove storage eventcore:flags $(name)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"flag.clear","color":"#FFAA00"},{"text":"$(name)","color":"white"}]
