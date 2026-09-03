$data modify storage macroengine:engine _dispatch.func set value "$(func)"
execute as @a at @s run function #macroengine:internal/dispatch
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"lib/for_each_player_at ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
