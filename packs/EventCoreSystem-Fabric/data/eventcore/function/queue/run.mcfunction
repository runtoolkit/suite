# İsimli kuyruğu çalıştır ve temizle. Kullanım: {queue:"my_queue"}
$data modify storage eventcore:sys event_queue set from storage eventcore:queues $(queue)
$data remove storage eventcore:queues $(queue)
# Priority sıralama — trigger/multi ile tutarlı
execute if data storage eventcore:sys event_queue[0] run function eventcore:events/sort
execute if data storage eventcore:sys event_queue[0] run function eventcore:events/process
data remove storage eventcore:sys event_queue
