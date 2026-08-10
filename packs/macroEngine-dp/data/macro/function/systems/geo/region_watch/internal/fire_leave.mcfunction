# macro:systems/geo/region_watch/internal/fire_leave [MACRO]
# INPUT: $(on_leave) — from _rw_cur; called ONLY when on_leave field exists.
# @s = player leaving the region

$data modify storage macro:engine _dispatch.func set value "$(on_leave)"
function #macro:internal/dispatch
