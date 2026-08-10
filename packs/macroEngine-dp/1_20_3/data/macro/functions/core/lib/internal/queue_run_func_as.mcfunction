$data modify storage macro:engine _dispatch.func set value "$(func)"
$execute as $(player) at @s run function #macro:internal/dispatch
