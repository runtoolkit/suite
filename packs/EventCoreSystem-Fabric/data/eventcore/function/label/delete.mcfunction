# Kaydedilmiş bir eventi sil.
# Kullanım: {label:"my_event"}
$data remove storage eventcore:labels $(label)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"label.delete","color":"#FFAA00"},{"text":"label=","color":"#AAAAAA"},{"text":"$(label)","color":"white"}]
