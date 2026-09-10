# macroengine:backport/detect
# Detects Minecraft version and loads appropriate backports
# This is a base stub; overlays override it.

# Default to modern
scoreboard players set #macroengine.mc_version macroengine.meta 107

# Call the overlay-specific backport/load if present
function macroengine:backport/load
