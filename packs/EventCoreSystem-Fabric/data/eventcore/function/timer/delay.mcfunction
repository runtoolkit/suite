# Gecikmeli komut çalıştırma
$schedule function $(func) $(delay)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"timer.delay","color":"#FFAA00"},{"text":"func=","color":"#AAAAAA"},{"text":"$(func)","color":"white"},{"text":" | ","color":"#555555"},{"text":"delay=","color":"#AAAAAA"},{"text":"$(delay)","color":"white"}]
