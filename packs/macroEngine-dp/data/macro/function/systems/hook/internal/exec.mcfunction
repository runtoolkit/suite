# macro:systems/hook/internal/exec [MACRO]
# INPUT: $(func) — guaranteed present (check_bind ensures func exists)
# @s = the triggering player

$data modify storage macro:engine _dispatch.func set value "$(func)"
function #macro:internal/dispatch
