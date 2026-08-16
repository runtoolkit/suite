execute unless data storage macroengine:engine trigger_binds run return 0

data modify storage macroengine:engine _tc_unbind set from storage macroengine:engine trigger_binds
data modify storage macroengine:engine trigger_binds set value []

$data modify storage macroengine:engine _tc_uval set value $(value)
function macroengine:core/internal/api/trigger/unbind_filter
data remove storage macroengine:engine _tc_unbind
data remove storage macroengine:engine _tc_uval
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"trigger/unbind ","color":"aqua"},{"text":"✘ ","color":"red"},{"text":"value=$(value)","color":"white"},{"text":" removed","color":"#555555"}]
