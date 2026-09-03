# macroengine:core/lib/fiber/internal/is_alive_exec [MACRO]
# INPUT: $(id)

data modify storage macroengine:output result set value 0b
$execute if data storage macroengine:engine fibers.$(id){alive:1b} run data modify storage macroengine:output result set value 1b

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/fiber/is_alive ","color":"aqua"},{"text":"$(id)","color":"white"},{"text":" → ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
