$data modify storage macroengine:input player set value "$(player)"
$data modify storage macroengine:input key set value "$(key)"
function macroengine:core/cooldown/check with storage macroengine:input {}
# check: result=0b → cooldown active. is_ready returns the inverse.
execute if data storage macroengine:output {result:0b} run data modify storage macroengine:output result set value 1b
execute if data storage macroengine:output {result:1b} run data modify storage macroengine:output result set value 0b
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"cooldown/is_ready ","color":"aqua"},{"text":"$(player):$(key) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
