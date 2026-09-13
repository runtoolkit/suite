# macroengine:experimental/scoreboard_hud/toggle
# Toggles a global sidebar scoreboard showing macroengine.perm_level and
# macroengine.exp_combat_timer for every online player (a small
# general-purpose status HUD, not tied to one specific feature).
# Gated behind flags.experimental.scoreboard_hud.
#
# Usage:  function macroengine:experimental/scoreboard_hud/toggle
# Caller: macroengine.admin tag required (server-wide display, not per-player)

execute unless entity @s[tag=macroengine.admin] run return 0
execute unless data storage macroengine:engine flags.experimental{scoreboard_hud:1b} run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"experimental/scoreboard_hud is disabled.","color":"red"}]
execute unless data storage macroengine:engine flags.experimental{scoreboard_hud:1b} run return 0

execute if score #exp_hud_on macroengine.tmp matches 1 run function macroengine:experimental/scoreboard_hud/hide
execute if score #exp_hud_on macroengine.tmp matches 1 run return 0

function macroengine:experimental/scoreboard_hud/show
