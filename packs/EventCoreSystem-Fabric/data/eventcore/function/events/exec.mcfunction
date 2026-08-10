# Kuyruğun ilk eventini işler, kaldırır, sonra sıradaki için process'i çağırır.
# ÖNEMLİ: dispatch args'ı okuduktan SONRA process çağrılır; iç içe çağrılar güvenlidir.
data modify storage eventcore:sys args set from storage eventcore:sys event_queue[0]
data remove storage eventcore:sys event_queue[0]

# Per-event koşul kontrolü (condition:{flag:"name"} / condition:{unless_flag:"name"})
scoreboard players set #ec_cond_skip ec.sys 0
execute if data storage eventcore:sys args.condition.flag run function eventcore:events/check_cond_flag with storage eventcore:sys args.condition
execute if data storage eventcore:sys args.condition.unless_flag run function eventcore:events/check_cond_unless_flag with storage eventcore:sys args.condition

# Koşul geçildi (skip=0) → normal dispatch; geçilemedi (skip=1) → atla
execute if score #ec_cond_skip ec.sys matches 0 unless data storage eventcore:sys args.type if data storage eventcore:config errors{show:1} run tellraw @a [{"storage":"eventcore:config","nbt":"messages.err_prefix","color":"red","bold":true},{"text":" ","color":"white"},{"storage":"eventcore:config","nbt":"messages.err_no_type","color":"white"}]
execute if score #ec_cond_skip ec.sys matches 0 if data storage eventcore:sys args.type run function eventcore:internal/dispatch
function eventcore:events/process
data remove storage eventcore:sys args
