# macroengine:systems/flag/experimental/set [MACRO]
# Enables or disables one experimental flag. Internal — called by
# api/toggle/experimental/true|false so admin-tag gating happens once,
# at the caller, not duplicated here.
#
# INPUT (macro):
#   $(flag)  -> one of: strict_gating, hologram, particle_trail,
#               crafting_ui, waypoint, combat_tag, scoreboard_hud
#   $(value) -> literal "1b" or "0b" (NBT byte literal, passed as string)

$data modify storage macroengine:engine flags.experimental.$(flag) set value $(value)
