# DL Tick Engine — Simplified Entry Point
# Driven by #minecraft:tick function tag (guaranteed 1/game-tick, no drift).
#
# Runtime channel registry removed. Systems are called directly from
# core/tick/dispatch.mcfunction with fixed rates (see that file).
# Do NOT add per-system logic here — add it to dispatch.mcfunction instead.
#
# Merged in from the former macroengine.main:macroengine/tick (runtoolkit
# dispatch removed — this function is now called directly via
# #minecraft:tick, see data/minecraft/tags/function/tick.json).

# Config-level pause guard (separate from the storage-level pause below)
execute if score #runtoolkit.packs.macroengine.config.tick.pause macroengine.meta matches 1 run return 0

# Ensure tick config defaults exist (idempotent, only fills missing keys)
execute unless score #runtoolkit.packs.macroengine.config.tick.rate macroengine.meta matches 1.. run function macroengine:config/tick_cfg

# If tick.rate is not >= 1, skip the real tick work and run the no-op once instead
execute if score #runtoolkit.packs.macroengine.config.tick.rate macroengine.meta matches ..0 run function macroengine:core/empty
execute if score #runtoolkit.packs.macroengine.config.tick.rate macroengine.meta matches ..0 run return 0

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

# Per-player input polling (writable book, command block minecart, etc.) —
# independent of the dispatch chain below.
execute as @a if score #runtoolkit.packs.macroengine.config.tick.rate macroengine.meta matches 1.. run function #macroengine:loop

function macroengine:core/tick/dispatch