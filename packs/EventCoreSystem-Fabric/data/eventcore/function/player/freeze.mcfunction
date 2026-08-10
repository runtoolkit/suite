# Oyuncuyu dondurma / çözme
$execute as @a[name=$(target),limit=1,tag=!ec.freezed] at @s run return run tag @s add ec.freezed

$execute as @a[name=$(target),limit=1,tag=ec.freezed] at @s run return run tag @s remove ec.freezed
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"player.freeze","color":"#FFAA00"},{"text":"→ ","color":"#AAAAAA"},{"text":"$(target)","color":"white"}]
