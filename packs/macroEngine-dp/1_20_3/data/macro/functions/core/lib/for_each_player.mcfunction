$data modify storage macro:engine _dispatch.func set value "$(func)"
execute as @a run function #macro:internal/dispatch
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"lib/for_each_player ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
