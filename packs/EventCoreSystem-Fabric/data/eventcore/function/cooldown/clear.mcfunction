# Oyuncu cooldown'unu temizle.
# Kullanım: {player:"Steve",id:"attack"}
$data remove storage eventcore:cooldown $(player).$(id)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"cooldown.clear","color":"#FFAA00"},{"text":"player=","color":"#AAAAAA"},{"text":"$(player)","color":"white"},{"text":" | ","color":"#555555"},{"text":"id=","color":"#AAAAAA"},{"text":"$(id)","color":"white"}]
