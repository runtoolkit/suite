# Timer'ı durdurma
$schedule clear $(func)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"timer.stop","color":"#FFAA00"},{"text":"func=","color":"#AAAAAA"},{"text":"$(func)","color":"white"}]
