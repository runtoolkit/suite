$data modify storage macroengine:engine queue append value {cmd:"$(cmd)", delay:$(delay)}
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/queue_add_cmd ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(cmd)","color":"aqua"}]
