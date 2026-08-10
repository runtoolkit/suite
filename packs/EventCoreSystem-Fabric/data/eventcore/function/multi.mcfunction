# EventCore Çoklu Event Giriş Noktası
# Kullanım: function eventcore:multi {events:[{type:"...",data:{...}},...]}
$data modify storage eventcore:sys event_queue set value $(events)

# Versiyon güvenlik kontrolü
execute unless data storage eventcore:config {version:"2.5.0"} run tellraw @a [{"storage":"eventcore:config","nbt":"messages.err_prefix","color":"red","bold":true},{"text":" ","color":"white"},{"storage":"eventcore:config","nbt":"messages.err_version","color":"white"}]
execute unless data storage eventcore:config {version:"2.5.0"} run return fail

# Max queue size ve priority sıralama
execute if data storage eventcore:sys event_queue[0] run function eventcore:events/check_size with storage eventcore:config
execute if data storage eventcore:sys event_queue[0] run function eventcore:events/sort

function eventcore:events/process
data remove storage eventcore:sys event_queue
