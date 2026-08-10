# Skoru eventcore:sys math_result int olarak sakla.
# Kullanım: {name:"foo",obj:"my_obj"}
$execute store result storage eventcore:sys math_result int 1 run scoreboard players get $(name) $(obj)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"math.get","color":"#FFAA00"},{"text":"$(name)","color":"white"},{"text":" → sys.math_result","color":"#AAAAAA"}]
