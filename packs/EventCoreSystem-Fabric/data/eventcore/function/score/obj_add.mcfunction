$scoreboard objectives add $(obj) $(type)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"score.obj_add","color":"#FFAA00"},{"text":"obj=","color":"#AAAAAA"},{"text":"$(obj)","color":"white"},{"text":" | ","color":"#555555"},{"text":"type=","color":"#AAAAAA"},{"text":"$(type)","color":"white"}]
