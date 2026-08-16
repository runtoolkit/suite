# macroengine:api/interaction/bind_attack
# Binds a function to an interaction entity attack event.
#
# INPUT:
# macroengine:input tag — entity tag to match
# macroengine:input func — function to call on attack
#
# USAGE:
# data modify storage macroengine:input tag set value "my_interact"
# data modify storage macroengine:input func set value "mypack:on_attack"
# function macroengine:api/interaction/bind_attack with storage macroengine:input {}
function macroengine:core/internal/api/interaction/bind_attack_do with storage macroengine:input {}
