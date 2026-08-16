# macroengine:core/lib/fiber/internal/spawn_exec [MACRO]
# INPUT: $(id), $(func)

# Delete if same id exists
$data remove storage macroengine:engine fibers.$(id)

# Create fiber record
$data modify storage macroengine:engine fibers.$(id) set value {alive:1b}

# Run first step via central dispatch
$data modify storage macroengine:engine _dispatch.func set value "$(func)"
function #macroengine:internal/dispatch

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/fiber/spawn ","color":"aqua"},{"text":"[start] ","color":"green"},{"text":"$(id)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
