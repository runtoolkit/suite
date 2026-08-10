$scoreboard players reset $(target) $(obj)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"score.reset","color":"#FFAA00"},{"text":"$(target)","color":"white"},{"text":" | ","color":"#555555"},{"text":"obj=","color":"#AAAAAA"},{"text":"$(obj)","color":"white"}]
