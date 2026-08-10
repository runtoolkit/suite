# events[] max_queue_size'ı aşıyorsa uyarı ver ve kuyruğu temizle.
# config storage'ı ile macro olarak çağrılır.
$execute if data storage eventcore:sys event_queue[$(max_queue_size)] if data storage eventcore:config errors{show:1} run tellraw @a [{"storage":"eventcore:config","nbt":"messages.err_prefix","color":"red","bold":true},{"text":" ","color":"white"},{"storage":"eventcore:config","nbt":"messages.err_queue_limit","color":"white"}]
$execute if data storage eventcore:sys event_queue[$(max_queue_size)] run data remove storage eventcore:sys event_queue
