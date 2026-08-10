# Flag'ı tersine çevir. Yoksa 1b yapar. Kullanım: {name:"my_flag"}
$execute if data storage eventcore:flags {$(name):1} run data modify storage eventcore:flags $(name) set value 0
$execute if data storage eventcore:flags {$(name):0} run data modify storage eventcore:flags $(name) set value 1
$execute unless data storage eventcore:flags $(name) run data modify storage eventcore:flags $(name) set value 1
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"flag.toggle","color":"#FFAA00"},{"text":"$(name)","color":"white"}]
