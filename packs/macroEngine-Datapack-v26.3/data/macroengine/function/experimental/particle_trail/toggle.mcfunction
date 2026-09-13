# macroengine:experimental/particle_trail/toggle
# Toggles a per-player particle trail (spawns particles behind the
# player as they move). Gated behind flags.experimental.particle_trail.
# Tick loop hook lives in experimental/particle_trail/tick.mcfunction.
#
# Usage:  function macroengine:experimental/particle_trail/toggle
# Caller: any player (self-toggle, no admin tag needed)

execute unless data storage macroengine:engine flags.experimental{particle_trail:1b} run tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"experimental/particle_trail is disabled.","color":"red"}]
execute unless data storage macroengine:engine flags.experimental{particle_trail:1b} run return 0

# BUGFIX (was always resolving to "on"): the old code removed the tag
# first, then re-checked `if entity @s[tag=...trail]` — which was now
# always false since the tag had just been removed — so the early
# `return 0` never fired and execution fell through to the `add` line,
# re-adding the tag every time.
#
# Fix: test the tag exactly once. `return run` short-circuits this
# function on the first branch that matches, so the second `execute`
# line never runs when the first one did — the tag is never re-tested
# after being mutated.
execute if entity @s[tag=macroengine.experimental.trail] run return run function macroengine:experimental/particle_trail/toggle_off
execute unless entity @s[tag=macroengine.experimental.trail] run return run function macroengine:experimental/particle_trail/toggle_on
