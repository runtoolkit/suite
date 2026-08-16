# DL Tick Engine v2 — Entry Point
# Driven by #minecraft:tick function tag (guaranteed 1/game-tick, no drift).
#
# All rate/offset/condition/pause logic is inside the channel dispatcher.
# Do NOT add any per-system logic here — register a channel instead.

# Guard: no players online → nothing to process
execute unless entity @a run return 0

# Guard: engine not initialised
# (loaded flag lives under global.loaded — see macroengine_load:load/all which sets
#  `macroengine:engine global.loaded`; every other guard in the pack, e.g.
#  core/security/cmd_gate.mcfunction, already checks the correct path)
execute unless data storage macroengine:engine global{loaded:1b} run return 0

# Online player count — kept for compatibility
execute store result score #online macroengine.onlinePlayers if entity @a

# Guard: globally paused (macroengine:core/tick/pause / macroengine:core/tick/resume)
execute if data storage macroengine:engine tick{paused:1b} run return 0

execute as @a run function macroengine:core/tick/dispatch