# Tekrarlayan komut
$schedule function $(func) $(interval) replace
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"timer.repeat","color":"#FFAA00"},{"text":"func=","color":"#AAAAAA"},{"text":"$(func)","color":"white"},{"text":" | ","color":"#555555"},{"text":"interval=","color":"#AAAAAA"},{"text":"$(interval)","color":"white"}]
