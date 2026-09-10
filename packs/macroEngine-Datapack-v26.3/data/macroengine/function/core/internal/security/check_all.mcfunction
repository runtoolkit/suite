# ─────────────────────────────────────────────────────────────────
# macroengine:core/internal/security/check_all [MACRO]
#
# THE central permission gate for cmd/, cb/, and raw wand/trigger
# dispatch. This is the function `admin_min_level`, `cmd_min_level`,
# and `sandbox_cmd_min_level` have been documented as enforcing
# (via "(check_all)" / "SECURITY: caller must hold...") since v6.0.2,
# but the function never existed — nothing actually read
# macroengine.perm_level anywhere in the pack. This file closes that gap.
#
# Gated behind flags.experimental.strict_gating (systems/flag/experimental).
# Flag OFF -> always return 1 (pass), i.e. identical to current
# (unenforced) behavior. This is a real kill switch: if strict_gating
# causes problems again, disable the flag and every caller of this
# function silently no-ops back to "allow everyone", no code changes
# needed. Flag ON -> live perm_level enforcement below.
#
# Run `as <player>` — @s IS the caller. Matches the pack's existing
# convention (api/cmd/*, api/cb/* already assume @s is the executor).
#
# INPUT (macro, required):
#   $(required) -> threshold key in `security` storage to check against:
#                   "cmd_min_level" | "sandbox_cmd_min_level" | "admin_min_level"
#
# OUTPUT: returns 1 if allowed, 0 if denied.
#   On denial: runs core/fallback/no_permission as the same @s (tellraw +
#   log), matching no_permission's own docstring ("perm_level below
#   required threshold").
# ─────────────────────────────────────────────────────────────────

# Flag OFF -> unconditional pass (backward-compatible / kill-switch default)
execute unless data storage macroengine:engine flags.experimental{strict_gating:1b} run return 1

# admin tag always passes, regardless of numeric perm_level
execute if entity @s[tag=macroengine.admin] run return 1

scoreboard players set $ca_required macroengine.tmp -1
$execute store result score $ca_required macroengine.tmp run data get storage macroengine:engine security.$(required)

execute if score @s macroengine.perm_level >= $ca_required macroengine.tmp run return 1

# Denied
function macroengine:core/fallback/no_permission
return 0
