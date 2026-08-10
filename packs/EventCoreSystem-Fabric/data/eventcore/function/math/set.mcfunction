# Skor değeri ayarla.
# Kullanım: {name:"foo",obj:"my_obj",value:10}
$scoreboard players set $(name) $(obj) $(value)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"math.set","color":"#FFAA00"},{"text":"$(name)","color":"white"},{"text":" = ","color":"#AAAAAA"},{"text":"$(value)","color":"yellow"}]
