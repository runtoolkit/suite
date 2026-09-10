# macroengine:experimental/particle_trail/tick
# Runs every tick from core/tick/player_systems.mcfunction (only while
# flags.experimental.particle_trail is on). Spawns a small particle burst
# under each player tagged macroengine.experimental.trail (set via
# experimental/particle_trail/toggle.mcfunction).
#
# Kept as a single unconditional particle command run `as @a[tag=...]`
# rather than a manual entity loop — matches the pack's existing style
# (e.g. core/tick/hud_systems.mcfunction) of letting selectors do the
# fan-out instead of hand-written iteration.

execute unless data storage macroengine:engine flags.experimental{particle_trail:1b} run return 0

execute as @a[tag=macroengine.experimental.trail] at @s run particle minecraft:end_rod ~ ~0.1 ~ 0.1 0 0.1 0.01 2 force
