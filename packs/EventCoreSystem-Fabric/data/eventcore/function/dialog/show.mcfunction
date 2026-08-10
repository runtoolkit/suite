$dialog show $(target) $(dialog)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"dialog.show","color":"#FFAA00"},{"text":"→ ","color":"#AAAAAA"},{"text":"$(target)","color":"white"},{"text":" | ","color":"#555555"},{"text":"dialog=","color":"#AAAAAA"},{"text":"$(dialog)","color":"white"}]
