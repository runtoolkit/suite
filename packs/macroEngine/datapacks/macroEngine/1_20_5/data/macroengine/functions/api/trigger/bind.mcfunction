execute unless data storage macroengine:engine trigger_binds run data modify storage macroengine:engine trigger_binds set value []

$data modify storage macroengine:engine trigger_binds append value {value:$(value), func:"$(func)"}
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"trigger/bind ","color":"aqua"},{"text":"✔ ","color":"green"},{"text":"$(value)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
