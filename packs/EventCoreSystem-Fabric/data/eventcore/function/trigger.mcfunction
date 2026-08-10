# EventCore Ana Yönlendirici — Tekil + Çoklu + Config
# Kullanım: function eventcore:trigger {args:{...},events:[...],config:{...}}
# args:{} boş geçilebilir. events:[] boş geçilebilir. İkisi birden de olabilir.
# config:{} seçenekleri:
#   delay:N            — N tick sonra çalıştır
#   version_check:0b   — versiyon kontrolünü atla
#   as:"selector"      — execute as <selector>
#   at:"selector"      — execute at <selector>
#   silent:1b          — debug çıktısını sustur
#   if_flag:"name"     — bayrak 1b ise çalış, değilse iptal
#   unless_flag:"name" — bayrak 0b/yok ise çalış, 1b ise iptal
# events[] içinde {type:"...",data:{...},priority:"high"|"low"} ile öncelik verilebilir.
# events[] item'ında condition:{flag:"name"} veya condition:{unless_flag:"name"} ile per-event koşul.
$data modify storage eventcore:sys args set value $(args)
$data modify storage eventcore:sys event_queue set value $(events)
$data modify storage eventcore:sys config_call set value $(config)

# Versiyon kontrolü (config:{version_check:0} ile devre dışı bırakılabilir)
execute unless data storage eventcore:sys config_call{version_check:0} unless data storage eventcore:config {version:"2.4.2"} run tellraw @a [{"storage":"eventcore:config","nbt":"messages.err_prefix","color":"red","bold":true},{"text":" ","color":"white"},{"storage":"eventcore:config","nbt":"messages.err_version","color":"white"}]
execute unless data storage eventcore:sys config_call{version_check:0} unless data storage eventcore:config {version:"2.4.2"} run return fail

# Geciktirme — config:{delay:N} varsa defer et (cleanup defer içinde yapılır)
execute if data storage eventcore:sys config_call.delay run function eventcore:trigger/defer
execute if data storage eventcore:sys config_call.delay run return 0

# Koşullu çalışma — config:{if_flag:"name"} veya config:{unless_flag:"name"}
scoreboard players set #ec_flag_pass ec.sys 1
execute if data storage eventcore:sys config_call.if_flag run function eventcore:trigger/guard_if_flag with storage eventcore:sys config_call
execute if data storage eventcore:sys config_call.unless_flag run function eventcore:trigger/guard_unless_flag with storage eventcore:sys config_call
execute if score #ec_flag_pass ec.sys matches 0 run data remove storage eventcore:sys config_call
execute if score #ec_flag_pass ec.sys matches 0 run data remove storage eventcore:sys args
execute if score #ec_flag_pass ec.sys matches 0 run data remove storage eventcore:sys event_queue
execute if score #ec_flag_pass ec.sys matches 0 run return 0
scoreboard players reset #ec_flag_pass ec.sys

# Max queue size kontrolü
execute if data storage eventcore:sys event_queue[0] run function eventcore:events/check_size with storage eventcore:config

# Priority sıralama — event_queue'da eleman varsa sırala
execute if data storage eventcore:sys event_queue[0] run function eventcore:events/sort

# Yürütme bağlamı — as+at / as / at / normal
execute if data storage eventcore:sys config_call.as if data storage eventcore:sys config_call.at run function eventcore:trigger/run_as_at with storage eventcore:sys config_call
execute if data storage eventcore:sys config_call.as unless data storage eventcore:sys config_call.at run function eventcore:trigger/run_as with storage eventcore:sys config_call
execute unless data storage eventcore:sys config_call.as if data storage eventcore:sys config_call.at run function eventcore:trigger/run_at with storage eventcore:sys config_call
execute unless data storage eventcore:sys config_call.as unless data storage eventcore:sys config_call.at run function eventcore:trigger/run_core

data remove storage eventcore:sys config_call
data remove storage eventcore:sys args
data remove storage eventcore:sys event_queue
