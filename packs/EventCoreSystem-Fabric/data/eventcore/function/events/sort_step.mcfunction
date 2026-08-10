# event_queue[0]'ı priority'e göre sort_high / sort_normal / sort_low'a taşır. Recursive.
# NOT: [0]{priority:"..."} 1.21.11'de geçersiz — sort_tmp üzerinden kontrol edilir.
data modify storage eventcore:sys sort_tmp set from storage eventcore:sys event_queue[0]
execute if data storage eventcore:sys sort_tmp{priority:"high"} run data modify storage eventcore:sys sort_high append from storage eventcore:sys sort_tmp
execute if data storage eventcore:sys sort_tmp{priority:"low"} run data modify storage eventcore:sys sort_low append from storage eventcore:sys sort_tmp
execute unless data storage eventcore:sys sort_tmp{priority:"high"} unless data storage eventcore:sys sort_tmp{priority:"low"} run data modify storage eventcore:sys sort_normal append from storage eventcore:sys sort_tmp
data remove storage eventcore:sys sort_tmp
data remove storage eventcore:sys event_queue[0]
execute if data storage eventcore:sys event_queue[0] run function eventcore:events/sort_step
