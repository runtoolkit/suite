# Oyuncu başına cooldown ayarla.
# Kullanım: {player:"Steve",id:"attack",duration:100}
$scoreboard players set #ec_cd_tmp ec.sys $(duration)
scoreboard players operation #ec_cd_tmp ec.sys += #ec ec.sys
$execute store result storage eventcore:cooldown $(player).$(id) int 1 run scoreboard players get #ec_cd_tmp ec.sys
scoreboard players reset #ec_cd_tmp ec.sys
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"cooldown.set","color":"#FFAA00"},{"text":"player=","color":"#AAAAAA"},{"text":"$(player)","color":"white"},{"text":" | ","color":"#555555"},{"text":"id=","color":"#AAAAAA"},{"text":"$(id)","color":"white"},{"text":" | ","color":"#555555"},{"text":"dur=","color":"#AAAAAA"},{"text":"$(duration)","color":"white"}]
