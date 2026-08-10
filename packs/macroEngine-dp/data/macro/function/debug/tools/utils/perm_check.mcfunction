# macro:debug/tools/utils/perm_check
# Returns 1 if executor has sufficient ame.perm_level for admin commands.
# Returns 0 (+ fallback) if not.
#
# BREAKING CHANGE (v5.1.0): macro.admin tag alone no longer grants access.
# Players must have ame.perm_level >= security.admin_min_level.
# Non-player callers (server/datapack) are trusted and pass through.
#
# Set player level:  function macro:api/security/set_level {player:"Name",level:2}

# Non-players pass through (server-side / datapack callers are op-gated)
execute unless entity @s[type=minecraft:player] run return 1

# Load required admin level from security storage
execute store result score #perm_req macro.tmp run data get storage macro:engine security.admin_min_level

# Check perm_level
execute if score @s ame.perm_level >= #perm_req macro.tmp run return 1

# Denied
function macro:core/fallback/no_permission
return 0
