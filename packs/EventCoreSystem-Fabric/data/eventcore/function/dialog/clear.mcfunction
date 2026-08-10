$dialog clear $(target)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"dialog.clear","color":"#FFAA00"},{"text":"→ ","color":"#AAAAAA"},{"text":"$(target)","color":"white"}]
