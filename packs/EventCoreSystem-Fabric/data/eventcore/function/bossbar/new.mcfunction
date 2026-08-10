$bossbar add $(id) {"text":"$(name)","color":"$(color)"}
$bossbar set $(id) max $(max)
$bossbar set $(id) value $(val)
$bossbar set $(id) visible true
$bossbar set $(id) players $(user)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"bossbar.new","color":"#FFAA00"},{"text":"id=","color":"#AAAAAA"},{"text":"$(id)","color":"white"},{"text":" | ","color":"#555555"},{"text":"name=","color":"#AAAAAA"},{"text":"$(name)","color":"white"}]
