tag @s add macroengine.ia_active

data modify storage macroengine:engine _ia_iter set from storage macroengine:engine interaction_binds.use
execute if data storage macroengine:engine _ia_iter[0] run execute on target run function macroengine:core/internal/api/interaction/dispatch

tag @s remove macroengine.ia_active
data remove entity @s interaction
data remove storage macroengine:engine _ia_iter
data remove storage macroengine:engine _ia_cur
