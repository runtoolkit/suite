# Scoreboard = operasyonu — src'yi dst'ye kopyalar.
# Kullanım: {src_name:"foo",src_obj:"obj1",dst_name:"bar",dst_obj:"obj2"}
$scoreboard players operation $(dst_name) $(dst_obj) = $(src_name) $(src_obj)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"math.copy","color":"#FFAA00"},{"text":"$(src_name)","color":"white"},{"text":"→","color":"#AAAAAA"},{"text":"$(dst_name)","color":"white"}]
