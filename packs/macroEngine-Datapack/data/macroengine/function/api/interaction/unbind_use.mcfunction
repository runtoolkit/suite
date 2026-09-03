execute unless data storage macroengine:engine interaction_binds.use[0] run return 0

data modify storage macroengine:engine _ia_ubinds set from storage macroengine:engine interaction_binds.use
data modify storage macroengine:engine interaction_binds.use set value []
$data modify storage macroengine:engine _ia_ufilter set value {tag:"$(tag)", func:"$(func)", list:"use"}
function macroengine:core/internal/api/interaction/unbind_filter
data remove storage macroengine:engine _ia_ubinds
data remove storage macroengine:engine _ia_ufilter

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"interaction/unbind_use ","color":"aqua"},{"text":"✘ ","color":"red"},{"text":"$(tag)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
