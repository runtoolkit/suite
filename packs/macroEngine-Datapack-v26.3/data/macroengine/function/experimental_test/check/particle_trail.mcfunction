# macroengine:experimental_test/check/particle_trail [INTERNAL]
# Verifies experimental/particle_trail/toggle actually flips the
# macroengine.experimental.trail tag on and off (the bug the pack's
# own comments mention having fixed previously).

data modify storage macroengine:engine flags.experimental.particle_trail set value 1b

tag @s remove macroengine.experimental.trail
function macroengine:experimental/particle_trail/toggle
execute unless entity @s[tag=macroengine.experimental.trail] run function macroengine:experimental_test/signal {result:"fail"}
function macroengine:experimental/particle_trail/toggle
execute if entity @s[tag=macroengine.experimental.trail] run function macroengine:experimental_test/signal {result:"fail"}
execute unless entity @s[tag=macroengine.experimental.trail] run function macroengine:experimental_test/signal {result:"accept"}

data modify storage macroengine:engine flags.experimental.particle_trail set value 0b
