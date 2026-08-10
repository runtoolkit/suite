# ─────────────────────────────────────────────────────────────────
# macro:world/entity/for_each_in_radius
# Runs a function as every entity of a given type within radius
# of the named player.
#
# INPUT : $(player) → player name (origin)
#         $(type)   → entity type (e.g. "minecraft:zombie")
#         $(radius) → search radius in blocks
#         $(func)   → function to run as each entity (at its position)
#
# EXAMPLE:
# function macro:world/entity/for_each_in_radius {player:"Steve",type:"minecraft:zombie",radius:10,func:"mypack:on_zombie"}
# ─────────────────────────────────────────────────────────────────

$data modify storage macro:engine _dispatch.func set value "$(func)"
$execute as @a[name=$(player),limit=1] at @s run execute as @e[type=$(type),distance=..$(radius)] at @s run function #macro:internal/dispatch
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"entity/for_each_in_radius ","color":"aqua"},{"text":"$(player) r=$(radius) → ","color":"gray"},{"text":"$(type)","color":"aqua"}]
