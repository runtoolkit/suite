# macroengine:experimental_test/run_all
# TEMPORARY verification harness for the /test framework — checks that
# each experimental/* flag actually turns its feature on/off. This is
# throwaway scaffolding, not a shipped part of macroEngine: it (and
# the test_instance/test_environment/structure files it depends on)
# gets removed once verification is done.
#
# Usage:  /function macroengine:experimental_test/run_all
# Caller: macroengine.admin tag required (uses the same toggle API)
#
# Run this AFTER placing a test instance block loaded with
# macroengine:test/experimental_check nearby (or via /test run
# macroengine:experimental/<name>) so a start/fail/accept test block
# triplet exists within 8 blocks — the individual check_* functions
# signal pass/fail onto whichever accept/fail block is closest.

execute unless entity @s[tag=macroengine.admin] run return 0

tellraw @s ["",{"text":"[MACROENGINE/TEST] ","color":"#00AAAA","bold":true},{"text":"running experimental flag checks...","color":"gray"}]

function macroengine:experimental_test/check/hologram
function macroengine:experimental_test/check/particle_trail
function macroengine:experimental_test/check/waypoint
function macroengine:experimental_test/check/scoreboard_hud
function macroengine:experimental_test/check/combat_tag
function macroengine:experimental_test/check/crafting_ui

tellraw @s ["",{"text":"[MACROENGINE/TEST] ","color":"#00AAAA","bold":true},{"text":"done — check test block signals for pass/fail.","color":"gray"}]
