$tag $(target) add $(name)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"entity.tag_add","color":"#FFAA00"},{"text":"→ ","color":"#AAAAAA"},{"text":"$(target)","color":"white"},{"text":" | ","color":"#555555"},{"text":"tag=","color":"#AAAAAA"},{"text":"$(name)","color":"white"}]
