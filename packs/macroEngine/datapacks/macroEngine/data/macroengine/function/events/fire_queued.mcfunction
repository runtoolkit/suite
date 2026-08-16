$execute unless data storage macroengine:engine events.$(event) run return 0

$data modify storage macroengine:engine queue append value {func:"macroengine:events/internal/fire_deferred", delay:$(delay), event:"$(event)"}
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"event/fire_queued ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(event)","color":"aqua"}]