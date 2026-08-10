$gamemode $(mode) $(target)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"player.gamemode","color":"#FFAA00"},{"text":"→ ","color":"#AAAAAA"},{"text":"$(target)","color":"white"},{"text":" | ","color":"#555555"},{"text":"mode=","color":"#AAAAAA"},{"text":"$(mode)","color":"white"}]
