# DL Tick Engine — Simplified Entry Point
# Driven by #minecraft:tick function tag (guaranteed 1/game-tick, no drift).
#
# Runtime channel registry removed. Systems are called directly from
# core/tick/dispatch.mcfunction with fixed rates (see that file).
# Do NOT add per-system logic here — add it to dispatch.mcfunction instead.

# Guard: no players online → nothing to process
execute unless entity @a run return 0

# Guard: engine not initialised
# (loaded flag lives under global.loaded — see macroengine:core/internal/load/all which sets
#  `macroengine:engine global.loaded`; every other guard in the pack, e.g.
#  core/security/cmd_gate.mcfunction, already checks the correct path)
execute unless data storage macroengine:engine global{loaded:1b} run return 0

# Online player count — kept for compatibility
execute store result score #online macroengine.onlinePlayers if entity @a

# Guard: globally paused (set/clear via: data merge storage macroengine:engine {tick:{paused:1b}} )
execute if data storage macroengine:engine tick{paused:1b} run return 0

function macroengine:core/tick/dispatch