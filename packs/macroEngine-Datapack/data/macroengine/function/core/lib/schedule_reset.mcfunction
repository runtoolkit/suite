$execute unless data storage macroengine:engine schedules.$(key) run return 0

$data modify storage macroengine:engine _sreset set from storage macroengine:engine schedules.$(key)
$data modify storage macroengine:engine _sreset.key set value "$(key)"

$data remove storage macroengine:engine schedules.$(key)

execute if data storage macroengine:engine _sreset.func if data storage macroengine:engine _sreset.player run function macroengine:core/internal/core/lib/schedule_reset_do_as with storage macroengine:engine _sreset
execute if data storage macroengine:engine _sreset.func unless data storage macroengine:engine _sreset.player run function macroengine:core/internal/core/lib/schedule_reset_do with storage macroengine:engine _sreset
execute if data storage macroengine:engine _sreset.cmd if data storage macroengine:engine _sreset.player run function macroengine:core/internal/core/lib/schedule_reset_do_cmd_as with storage macroengine:engine _sreset
execute if data storage macroengine:engine _sreset.cmd unless data storage macroengine:engine _sreset.player run function macroengine:core/internal/core/lib/schedule_reset_do_cmd with storage macroengine:engine _sreset
data remove storage macroengine:engine _sreset
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/schedule_reset ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]
