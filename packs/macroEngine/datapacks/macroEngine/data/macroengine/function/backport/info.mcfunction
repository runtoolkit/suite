# macroengine:backport/info
# Public API - shows backport status.
# On modern versions this is minimal.
# Overlays provide detailed legacy info.

tellraw @s ["",{"text":"[MACROENGINE] Backport system active.","color":"aqua"}]
tellraw @s ["",{"text":"Version-specific compatibility is provided via overlays.","color":"gray"}]
