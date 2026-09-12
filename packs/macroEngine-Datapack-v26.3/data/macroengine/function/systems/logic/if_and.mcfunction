# macroengine:systems/logic/if_and [MACRO]
# Dispatches func only if BOTH a and b are non-zero (logical AND).
# Composes with the other logic/if_* functions and any score-producing
# api/systems function: store each side's 0/1 result on a score first,
# then feed both into this as $(a)/$(b).
#
# INPUT (macro):
#   $(a)    -> first operand score value (non-zero = true)
#   $(b)    -> second operand score value (non-zero = true)
#   $(func) -> function id to run via #macroengine:internal/dispatch if a && b

$scoreboard players set $if_and_a macroengine.tmp $(a)
$scoreboard players set $if_and_b macroengine.tmp $(b)
$data modify storage macroengine:engine _dispatch.func set value "$(func)"
execute unless score $if_and_a macroengine.tmp matches 0 unless score $if_and_b macroengine.tmp matches 0 run function #macroengine:internal/dispatch
