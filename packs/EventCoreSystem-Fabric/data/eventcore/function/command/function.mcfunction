$function $(ns):$(path)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"func.call","color":"#FFAA00"},{"text":"$(ns)","color":"white"},{"text":" | ","color":"#555555"},{"text":"path=","color":"#AAAAAA"},{"text":"$(path)","color":"white"}]
