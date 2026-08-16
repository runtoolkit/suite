$data modify storage macroengine:engine _dispatch.func set value "$(func)"
$execute as @e[type=$(type),tag=$(tag)] at @s run function #macroengine:internal/dispatch
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"entity/for_each ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(type)","color":"aqua"}]
