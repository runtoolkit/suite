# Sabit değer çıkar.
# Kullanım: {name:"foo",obj:"my_obj",value:5}
$scoreboard players remove $(name) $(obj) $(value)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"math.sub_const","color":"#FFAA00"},{"text":"$(name)","color":"white"},{"text":" -= ","color":"#AAAAAA"},{"text":"$(value)","color":"yellow"}]
