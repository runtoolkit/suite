$scoreboard players set $if_a macro.tmp $(a)
$scoreboard players set $if_b macro.tmp $(b)
$data modify storage macro:engine _dispatch.func set value "$(func)"
execute unless score $if_a macro.tmp = $if_b macro.tmp run function #macro:internal/dispatch
