# Ses durdur.
# Kullanım: {target:"@a",sound:"minecraft:music.game"}
$stopsound $(target) * $(sound)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"sound.stop","color":"#FFAA00"},{"text":"sound=","color":"#AAAAAA"},{"text":"$(sound)","color":"white"}]
