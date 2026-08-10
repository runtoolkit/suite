$execute unless data storage eventcore:sys args.data.effect run effect clear $(target)
$execute if data storage eventcore:sys args.data.effect run effect clear $(target) $(effect)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"effect.clear","color":"#FFAA00"},{"text":"→ ","color":"#AAAAAA"},{"text":"$(target)","color":"white"}]
