scoreboard players add $pq_depth macroengine.tmp 1
execute if score $pq_depth macroengine.tmp matches 257.. run return 0

execute unless data storage macroengine:engine queue[0] run return 0

execute store result score $qdel macroengine.tmp run data get storage macroengine:engine queue[0].delay

scoreboard players remove $qdel macroengine.tmp 1
execute store result storage macroengine:engine queue[0].delay int 1 run scoreboard players get $qdel macroengine.tmp

execute if score $qdel macroengine.tmp matches ..0 run function macroengine:core/internal/core/lib/queue_fire
execute if score $qdel macroengine.tmp matches ..0 run function macroengine:core/lib/process_queue
