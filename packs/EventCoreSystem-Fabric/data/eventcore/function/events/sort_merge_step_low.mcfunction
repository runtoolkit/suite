# sort_low elemanlarını event_queue'ya append eder. Recursive.
data modify storage eventcore:sys event_queue append from storage eventcore:sys sort_low[0]
data remove storage eventcore:sys sort_low[0]
execute if data storage eventcore:sys sort_low[0] run function eventcore:events/sort_merge_step_low
