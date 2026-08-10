$bossbar set $(id) value $(val)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"bossbar.set","color":"#FFAA00"},{"text":"id=","color":"#AAAAAA"},{"text":"$(id)","color":"white"},{"text":" | ","color":"#555555"},{"text":"val=","color":"#AAAAAA"},{"text":"$(val)","color":"white"}]
