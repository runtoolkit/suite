# macro: $(cmd)     as player
# Runs with the permission level datapack functions get (function-permission-level, default 2),
# not the player's own. cmd must come from menu code / definitions, never from player input.
#
# SECURITY (macroEngine port): raw $(cmd) execution goes through the central gate
# macroengine:core/internal/security/check_all {required:"cmd_min_level"}, same as api/cb/run.
#   - flags.experimental.strict_gating OFF (default): check_all always passes -> behaves exactly like the
#     original guikit (NO enforcement). This is a kill switch, not protection, until the flag is on.
#   - strict_gating ON: @s (the CLICKING player) needs macroengine.perm_level >= security.cmd_min_level,
#     or macroengine.admin. NOTE: this checks who CLICKS, not who WROTE the menu definition. A low-level
#     player clicking an admin-authored button is denied; that is the conservative direction.
# Reset first: if check_all yields no result the score would keep a stale 1 from an earlier click (fail-OPEN).
# Same pattern as api/cb/run.
scoreboard players set #macroengine.gate_ok macroengine.tmp 0
execute store result score #macroengine.gate_ok macroengine.tmp run function macroengine:core/internal/security/check_all {required:"cmd_min_level"}
execute unless score #macroengine.gate_ok macroengine.tmp matches 1 run return 0
$execute as @s at @s run $(cmd)
