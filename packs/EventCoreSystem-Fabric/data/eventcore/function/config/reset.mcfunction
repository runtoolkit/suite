# Tüm config bloklarını siler ve varsayılanları yeniden yükler.
data remove storage eventcore:config debug
data remove storage eventcore:config errors
data remove storage eventcore:config cmd
data remove storage eventcore:config broadcast
data remove storage eventcore:config on_load
data remove storage eventcore:config locale
data remove storage eventcore:config max_queue_size
data remove storage eventcore:config messages
function eventcore:config/load
tellraw @a [{"text":"[EventCore] ","color":"aqua","bold":true},{"text":"Config sıfırlandı!","color":"green"}]
