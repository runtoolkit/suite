# config:{delay:N} ile tetiklenir. args+events pending storage'a kopyalanır.
# schedule_delay macro ile gecikme ayarlanır.
# Tek pending slot — eş zamanlı birden fazla delay desteklenmez.
data modify storage eventcore:sys pending.args set from storage eventcore:sys args
data modify storage eventcore:sys pending.events set from storage eventcore:sys event_queue
function eventcore:trigger/schedule_delay with storage eventcore:sys config_call
# Defer sonrası storage temizliği (trigger.mcfunction'daki return fail sonrası çalışmaz)
data remove storage eventcore:sys args
data remove storage eventcore:sys event_queue
data remove storage eventcore:sys config_call
