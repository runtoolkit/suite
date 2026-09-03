# macroengine:core/lib/fiber/internal/kill_exec [MACRO]
# INPUT: $(id)

$execute unless data storage macroengine:engine fibers.$(id) run return 0

$data remove storage macroengine:engine fibers.$(id).alive
$data remove storage macroengine:engine fibers.$(id).resume

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/fiber/kill ","color":"aqua"},{"text":"[killed] ","color":"#FF5555"},{"text":"$(id)","color":"white"}]
