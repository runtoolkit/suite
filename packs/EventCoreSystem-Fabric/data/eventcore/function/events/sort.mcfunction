# event_queue'yu priority sırasına göre yeniden sıralar.
# Sıralama: "high" → (belirtilmemiş / normal) → "low"
data modify storage eventcore:sys sort_high set value []
data modify storage eventcore:sys sort_normal set value []
data modify storage eventcore:sys sort_low set value []
execute if data storage eventcore:sys event_queue[0] run function eventcore:events/sort_step
data modify storage eventcore:sys event_queue set from storage eventcore:sys sort_high
execute if data storage eventcore:sys sort_normal[0] run function eventcore:events/sort_merge_step
execute if data storage eventcore:sys sort_low[0] run function eventcore:events/sort_merge_step_low
data remove storage eventcore:sys sort_high
data remove storage eventcore:sys sort_normal
data remove storage eventcore:sys sort_low
