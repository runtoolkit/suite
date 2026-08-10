# Scoreboard operasyonu.
# Kullanım: {a_name:"foo",a_obj:"obj",op:"+=",b_name:"bar",b_obj:"obj"}
# op: += -= *= /= %= = < > ><
$scoreboard players operation $(a_name) $(a_obj) $(op) $(b_name) $(b_obj)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"math.op","color":"#FFAA00"},{"text":"$(a_name) $(op) $(b_name)","color":"white"}]
