# macroengine:core/lib/fiber/internal/resume_exec [MACRO]
# INPUT: $(id), $(func)
# Fed from _fib_cur.

# Is the fiber still alive?
$execute unless data storage macroengine:engine fibers.$(id){alive:1b} run return 0

# Run via central dispatch
$data modify storage macroengine:engine _dispatch.func set value "$(func)"
function #macroengine:internal/dispatch

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/fiber/resume ","color":"aqua"},{"text":"[run] ","color":"green"},{"text":"$(id)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
