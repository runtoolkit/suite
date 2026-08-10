$data modify storage macro:engine _dispatch.func set value "$(func)"
$execute as @e[type=$(type),tag=$(tag)] run function #macro:internal/dispatch
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"lib/for_each_entity ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(func)","color":"aqua"}]
