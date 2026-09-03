$execute unless data storage macroengine:engine schedules.$(key) run return 0
$data modify storage macroengine:engine _sched_tmp set from storage macroengine:engine schedules.$(key)
execute if data storage macroengine:engine _sched_tmp.func if data storage macroengine:engine _sched_tmp.player run function macroengine:core/internal/core/lib/schedule_requeue_as with storage macroengine:engine _sched_tmp
execute if data storage macroengine:engine _sched_tmp.func unless data storage macroengine:engine _sched_tmp.player run function macroengine:core/internal/core/lib/schedule_requeue with storage macroengine:engine _sched_tmp
execute if data storage macroengine:engine _sched_tmp.cmd if data storage macroengine:engine _sched_tmp.player run function macroengine:core/internal/core/lib/schedule_requeue_cmd_as with storage macroengine:engine _sched_tmp
execute if data storage macroengine:engine _sched_tmp.cmd unless data storage macroengine:engine _sched_tmp.player run function macroengine:core/internal/core/lib/schedule_requeue_cmd with storage macroengine:engine _sched_tmp
data remove storage macroengine:engine _sched_tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/schedule_renew ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]
