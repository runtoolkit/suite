# ─────────────────────────────────────────────────────────────────
# macro:core/security/cmd_gate
# Central security gate for all $$(cmd) execution points.
#
# Returns 1  → execution allowed.
# Returns 0  → denied; appropriate fallback already fired.
#
# Callers (all $$(cmd) sites):
#   execute unless function macro:core/security/cmd_gate run return 0
#   $$(cmd)
#
# SECURITY MODEL (v5.1.0+):
#   • Engine must be loaded (loaded:1b).
#   • Players require ame.perm_level >= security.cmd_min_level.
#   • sandbox:1b raises the floor to security.sandbox_cmd_min_level.
#   • Non-player callers (server/datapack) pass through — they are
#     already op-gated by the server itself.
#   • admin_can_override:0b means macro.admin tag gives no bypass.
# ─────────────────────────────────────────────────────────────────

# Guard 1: Engine must be loaded
execute unless data storage macro:engine global{loaded:1b} run function macro:core/fallback/not_loaded
execute unless data storage macro:engine global{loaded:1b} run return 0

# Guard 2: Permission level (players only; non-player callers are trusted)
# Read required minimum level from security storage
execute store result score #sec_req macro.tmp run data get storage macro:engine security.cmd_min_level

# Sandbox mode raises the bar
execute if data storage macro:engine {sandbox:1b} run execute store result score #sec_req macro.tmp run data get storage macro:engine security.sandbox_cmd_min_level

# Check and deny if player level is insufficient
execute if entity @s[type=minecraft:player] run execute unless score @s ame.perm_level >= #sec_req macro.tmp run function macro:core/security/cmd_perm_denied
execute if entity @s[type=minecraft:player] run execute unless score @s ame.perm_level >= #sec_req macro.tmp run return 0

return 1
