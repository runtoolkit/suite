$kick $(target) $(reason)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"player.kick","color":"#FFAA00"},{"text":"→ ","color":"#AAAAAA"},{"text":"$(target)","color":"white"},{"text":" | ","color":"#555555"},{"text":"reason: ","color":"#AAAAAA"},{"text":"$(reason)","color":"white"}]
