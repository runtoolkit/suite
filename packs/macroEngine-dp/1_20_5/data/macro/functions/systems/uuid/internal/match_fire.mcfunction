# ============================================================
# macro:systems/uuid/internal/match_fire [MACRO]
# Runs the uuid/match callback.
#
# Call: function macro:systems/uuid/internal/match_fire with storage macro:input {}
# $(func) = macro:input func field
# ============================================================
$data modify storage macro:engine _dispatch.func set value "$(func)"
function #macro:internal/dispatch
