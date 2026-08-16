# macroengine:core/lib/batch/internal/cancel_exec [MACRO]
# INPUT: $(id)

$execute unless data storage macroengine:engine batches.$(id) run return 0
$data remove storage macroengine:engine batches.$(id)

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/batch/cancel ","color":"aqua"},{"text":"$(id)","color":"white"},{"text":" — cancelled","color":"#FF5555"}]
