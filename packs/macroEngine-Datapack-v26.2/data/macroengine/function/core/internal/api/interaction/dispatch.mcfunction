data modify storage macroengine:engine _ia_cur set from storage macroengine:engine _ia_iter[0]
data remove storage macroengine:engine _ia_iter[0]

function macroengine:core/internal/api/interaction/check_bind with storage macroengine:engine _ia_cur

execute if data storage macroengine:engine _ia_iter[0] run function macroengine:core/internal/api/interaction/dispatch
