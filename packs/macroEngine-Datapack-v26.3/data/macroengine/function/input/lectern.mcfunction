# ======================================================================================
# macroengine:input/lectern
# ======================================================================================
#
# TRIGGERED BY: #macroengine:input/lectern function tag  OR  direct call
#   execute as <player> at @s anchored eyes positioned ^ ^ ^ run function macroengine:input/lectern
#
# PURPOSE:
#   Captures the raw text of page 0 of the book currently placed in the lectern
#   the player is looking at (short forward ray of ~5 blocks).
#   Stores into macroengine:input lectern.raw.
#   CAPTURE ONLY — no execution of the text.
#
# lectern.raw is RAW, UNVALIDATED text. Run it through
# macroengine:input/validate/check before treating it as a number/bool/tag-safe
# literal if required.
# ======================================================================================

execute if entity @s[type=minecraft:player] run function macroengine:input/private/lectern_ray_start
execute unless entity @s[type=minecraft:player] run return fail
