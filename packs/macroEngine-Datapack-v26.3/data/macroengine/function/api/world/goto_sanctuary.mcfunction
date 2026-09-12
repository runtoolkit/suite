# ─────────────────────────────────────────────────────────────────
# macroengine:api/world/goto_sanctuary
# Locates and teleports the caller to the nearest macroengine:gate_sanctuary
# biome — a no-spawn, no-precipitation biome intended as a safe admin/
# testing area (see worldgen/biome/gate_sanctuary.json).
#
# CAVEAT: worldgen/biome does not reload with /reload — the world must
# be restarted after this pack is first added for the biome to exist
# in that world's chunks. locate will fail with no result until then.
#
# Usage:  function macroengine:api/world/goto_sanctuary
# Caller: macroengine.admin tag required
# ─────────────────────────────────────────────────────────────────

execute unless entity @s[tag=macroengine.admin] run return 0

# /locate biome prints the nearest match with a clickable teleport
# suggestion directly to chat — there is no vanilla way to capture its
# result into a score/storage value for scripted teleport, so this
# function delegates to the vanilla command and lets the player click
# the result themselves.
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Locating nearest gate_sanctuary...","color":"gray"}]
locate biome macroengine:gate_sanctuary
