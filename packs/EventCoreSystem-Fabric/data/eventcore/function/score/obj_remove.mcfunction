$scoreboard objectives remove $(obj)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"score.obj_remove","color":"#FFAA00"},{"text":"obj=","color":"#AAAAAA"},{"text":"$(obj)","color":"white"}]
