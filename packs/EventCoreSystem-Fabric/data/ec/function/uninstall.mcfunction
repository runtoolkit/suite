# EventCore Kaldırıcı
# Kullanım: function ec:uninstall
data modify storage eventcore:config removed set value 1
data remove storage eventcore:config version
data remove storage eventcore:config debug
data remove storage eventcore:config errors
data remove storage eventcore:config cmd
data remove storage eventcore:config broadcast
data remove storage eventcore:config on_load
data remove storage eventcore:config locale
data remove storage eventcore:config max_queue_size
data remove storage eventcore:config messages
data remove storage eventcore:sys args
data remove storage eventcore:sys event_queue
data remove storage eventcore:sys config_call
data remove storage eventcore:sys pending
data remove storage eventcore:sys broadcast_args
data remove storage eventcore:sys cmd_queue
data remove storage eventcore:sys func_queue
data remove storage eventcore:sys current_cmd
data remove storage eventcore:sys current_func
data remove storage eventcore:sys sort_high
data remove storage eventcore:sys sort_normal
data remove storage eventcore:sys sort_low
data remove storage eventcore:sys sort_tmp
data remove storage eventcore:sys math_result
data remove storage eventcore:sys data_result
data remove storage eventcore:sys region_count
# Kullanıcı verisi — namespace silinemez, içleri boşaltılır
data merge storage eventcore:cooldown {}
data merge storage eventcore:flags {}
data merge storage eventcore:queues {}
data merge storage eventcore:labels {}
data merge storage eventcore:data {}
# Scoreboard temizliği
scoreboard objectives remove ec.sys
# Waypoint entity'leri temizle
kill @e[type=minecraft:marker,tag=waypoint]
tellraw @a [{"text":"[EventCore] ","color":"red","bold":true},{"text":"Kaldırıldı.","color":"white"}]
