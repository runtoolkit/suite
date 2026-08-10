# Gecikmiş yürütme — schedule tarafından çağrılır, config_call mevcut değildir.
data modify storage eventcore:sys args set from storage eventcore:sys pending.args
data modify storage eventcore:sys event_queue set from storage eventcore:sys pending.events
function eventcore:trigger/run_core
data remove storage eventcore:sys args
data remove storage eventcore:sys event_queue
data remove storage eventcore:sys pending
