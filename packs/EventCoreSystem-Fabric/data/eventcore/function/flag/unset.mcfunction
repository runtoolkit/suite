# Flag'ı 0b (false) yap. Kullanım: {name:"my_flag"}
$data modify storage eventcore:flags $(name) set value 0
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"flag.unset","color":"#FFAA00"},{"text":"$(name)","color":"white"}]
