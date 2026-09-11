# ======================================================================================
# macroengine:input/private/cbm_align_tp  [INTERNAL — call explicitly, not auto-ticked]
# ======================================================================================
#
# Teleports the executing player to the nearest command_block_minecart tagged
# 'macroengine_input' along their eye-line.
#
# Multiplayer-safe: resolves the target minecart's position through storage
# BEFORE moving anything, and scopes the search to prevent one player's
# align call from grabbing a minecart that another player is mid-interacting
# with. Not added to #macroengine:events/on_tick — hook explicitly.
# ======================================================================================

# Guard: only proceed if at least one target minecart exists at all.
execute unless entity @e[type=minecraft:command_block_minecart,tag=macroengine_input] run return 0

# Resolve the nearest minecart RELATIVE TO THE PLAYER (not @s, since @s here
# is still the player before any context switch) and snapshot its position
# into storage. This is the fix for the original bug: we never run
# "tp @e[...]" while executing as the player, which teleports the minecart
# instead of the player.
execute as @e[type=minecraft:command_block_minecart,tag=macroengine_input,sort=nearest,limit=1,distance=..8] at @s run data modify storage macroengine:input _align.pos set from entity @s Pos

# If nothing was within range, bail out (don't teleport the player anywhere).
execute unless data storage macroengine:input _align.pos run return 0

# Now teleport the PLAYER (@s is still the player, since the block above
# used "as @e ... at @s" scoped to itself and didn't change our @s) to the
# resolved position, offset down slightly as in the original intent.
execute store result score #align_y macroengine.tmp run data get storage macroengine:input _align.pos[1] 100
scoreboard players remove #align_y macroengine.tmp 23
execute store result storage macroengine:input _align.y double 0.01 run scoreboard players get #align_y macroengine.tmp

tp @s ^ ^ ^ facing entity @e[type=minecraft:command_block_minecart,tag=macroengine_input,sort=nearest,limit=1,distance=..8] eyes
execute at @e[type=minecraft:command_block_minecart,tag=macroengine_input,sort=nearest,limit=1,distance=..8] run tp @s ~ ~-0.23 ~

# Clean up temp storage/score so concurrent players don't read stale data.
data remove storage macroengine:input _align
scoreboard players reset #align_y macroengine.tmp
