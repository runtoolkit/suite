$data modify storage macro:engine _dispatch.func set value "$(func)"
$execute as @e[type=$(type),tag=$(tag)] at @s run function #macro:internal/dispatch
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"entity/for_each ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(type)","color":"aqua"}]
