$execute unless data storage eventcore:sys args.data.mode run experience add $(target) $(amount) points
$execute if data storage eventcore:sys args.data{mode:"levels"} run experience add $(target) $(amount) levels
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"xp.add","color":"#FFAA00"},{"text":"→ ","color":"#AAAAAA"},{"text":"$(target)","color":"white"},{"text":" | ","color":"#555555"},{"text":"amount=","color":"#AAAAAA"},{"text":"$(amount)","color":"white"}]
