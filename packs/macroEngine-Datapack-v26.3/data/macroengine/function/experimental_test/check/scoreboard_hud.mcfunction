# macroengine:experimental_test/check/scoreboard_hud [INTERNAL]
# Verifies experimental/scoreboard_hud/toggle flips #exp_hud_on
# between 0 and 1. Caller needs macroengine.admin (same requirement
# as the real function).

execute unless entity @s[tag=macroengine.admin] run return 0

data modify storage macroengine:engine flags.experimental.scoreboard_hud set value 1b
scoreboard players set #exp_hud_on macroengine.tmp 0

function macroengine:experimental/scoreboard_hud/toggle
execute unless score #exp_hud_on macroengine.tmp matches 1 run function macroengine:experimental_test/signal {result:"fail"}
function macroengine:experimental/scoreboard_hud/toggle
execute unless score #exp_hud_on macroengine.tmp matches 0 run function macroengine:experimental_test/signal {result:"fail"}
execute if score #exp_hud_on macroengine.tmp matches 0 run function macroengine:experimental_test/signal {result:"accept"}

data modify storage macroengine:engine flags.experimental.scoreboard_hud set value 0b
