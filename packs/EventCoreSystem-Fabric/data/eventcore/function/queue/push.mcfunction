# İsimli kuyruğa event ekle. Kullanım: {queue:"my_queue",event:{type:"...",data:{...}}}
$data modify storage eventcore:queues $(queue) append value $(event)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"queue.push","color":"#FFAA00"},{"text":"queue=","color":"#AAAAAA"},{"text":"$(queue)","color":"white"}]
