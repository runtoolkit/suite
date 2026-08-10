# İsimli kuyruğu temizle. Kullanım: {queue:"my_queue"}
$data remove storage eventcore:queues $(queue)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"queue.clear","color":"#FFAA00"},{"text":"queue=","color":"#AAAAAA"},{"text":"$(queue)","color":"white"}]
