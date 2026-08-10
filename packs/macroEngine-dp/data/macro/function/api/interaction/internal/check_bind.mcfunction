$data modify storage macro:engine _dispatch.func set value "$(func)"
$execute if entity @e[type=minecraft:interaction,tag=macro.ia_active,tag=$(tag),limit=1] run function #macro:internal/dispatch
