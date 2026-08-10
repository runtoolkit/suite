$bossbar remove $(id)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"bossbar.delete","color":"#FFAA00"},{"text":"id=","color":"#AAAAAA"},{"text":"$(id)","color":"white"}]
