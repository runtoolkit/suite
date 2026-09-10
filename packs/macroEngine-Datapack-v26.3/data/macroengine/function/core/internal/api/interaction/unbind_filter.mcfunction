execute unless data storage macroengine:engine _ia_ubinds[0] run return 0

data modify storage macroengine:engine _ia_ucur set from storage macroengine:engine _ia_ubinds[0]
data remove storage macroengine:engine _ia_ubinds[0]

function macroengine:core/internal/api/interaction/unbind_check with storage macroengine:engine _ia_ufilter

function macroengine:core/internal/api/interaction/unbind_filter
data remove storage macroengine:engine _ia_ucur
