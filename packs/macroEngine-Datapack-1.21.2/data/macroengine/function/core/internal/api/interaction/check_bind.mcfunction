$data modify storage macroengine:engine _dispatch.func set value "$(func)"
$execute if entity @e[type=minecraft:interaction,tag=macroengine.ia_active,tag=$(tag),limit=1] run function #macroengine:internal/dispatch
