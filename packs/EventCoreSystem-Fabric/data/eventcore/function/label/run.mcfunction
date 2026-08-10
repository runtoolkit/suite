# Kaydedilmiş bir eventi çalıştır.
# Kullanım: {label:"my_event"}
$data modify storage eventcore:sys args set from storage eventcore:labels $(label)
$execute unless data storage eventcore:sys args if data storage eventcore:config errors{show:1} run tellraw @a [{"storage":"eventcore:config","nbt":"messages.err_prefix","color":"red","bold":true},{"text":" Label bulunamadı: ","color":"white"},{"text":"$(label)","color":"yellow"}]
execute if data storage eventcore:sys args.type run function eventcore:internal/dispatch
data remove storage eventcore:sys args
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"label.run","color":"#FFAA00"},{"text":"label=","color":"#AAAAAA"},{"text":"$(label)","color":"white"}]
