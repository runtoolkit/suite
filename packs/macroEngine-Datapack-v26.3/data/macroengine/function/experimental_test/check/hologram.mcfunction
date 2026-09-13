# macroengine:experimental_test/check/hologram [INTERNAL]
# Verifies experimental/hologram: with the flag on, create should
# spawn a macroengine.experimental.hologram-tagged text_display near
# the caller; remove should despawn it again. Caller needs
# macroengine.admin (same requirement as the real hologram functions).

execute unless entity @s[tag=macroengine.admin] run return 0

data modify storage macroengine:engine flags.experimental.hologram set value 1b

function macroengine:experimental/hologram/create {text:"test"}
execute unless entity @e[tag=macroengine.experimental.hologram,distance=..5] run function macroengine:experimental_test/signal {result:"fail"}
execute if entity @e[tag=macroengine.experimental.hologram,distance=..5] run function macroengine:experimental/hologram/remove
execute if entity @e[tag=macroengine.experimental.hologram,distance=..5] run function macroengine:experimental_test/signal {result:"fail"}
execute unless entity @e[tag=macroengine.experimental.hologram,distance=..5] run function macroengine:experimental_test/signal {result:"accept"}

data modify storage macroengine:engine flags.experimental.hologram set value 0b
