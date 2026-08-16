$execute if data storage macroengine:engine schedules.$(key) run data remove storage macroengine:engine schedules.$(key)

$data modify storage macroengine:engine schedules.$(key).func set value "$(func)"
$data modify storage macroengine:engine schedules.$(key).interval set value $(interval)
$data modify storage macroengine:engine queue append value {func:"$(func)", delay:$(interval)}
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/schedule ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"}]
