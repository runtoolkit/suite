# Entity özelliklerini değiştirme
$execute as $(target) run data modify entity @s $(path) set value $(value)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"entity.modify","color":"#FFAA00"},{"text":"→ ","color":"#AAAAAA"},{"text":"$(target)","color":"white"},{"text":" | ","color":"#555555"},{"text":"path=","color":"#AAAAAA"},{"text":"$(path)","color":"white"}]
