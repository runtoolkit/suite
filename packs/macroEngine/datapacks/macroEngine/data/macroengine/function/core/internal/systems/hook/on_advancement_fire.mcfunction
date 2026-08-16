# macroengine:systems/hook/internal/on_advancement_fire [MACRO]
# INPUT: $(advancement)
# @s = player who earned the advancement

$data modify storage macroengine:engine _hook_fire_tmp set value {event:"advancement:$(advancement)"}
function macroengine:core/internal/systems/hook/fire with storage macroengine:engine _hook_fire_tmp
data remove storage macroengine:engine _hook_fire_tmp

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"hook/on_advancement_fire ","color":"aqua"},{"text":"advancement:$(advancement)","color":"yellow"}]
