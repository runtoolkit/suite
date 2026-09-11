# ======================================================================================
# macroengine:input/private/cbm_capture  [INTERNAL — do not call directly]
# ======================================================================================
#
# Only reached when Command is confirmed non-empty and no pending capture.
# Runs with @s = the command_block_minecart.
#
# No executed:0b/1b flag anymore. The pending tag is set right before the
# handler call and removed right after, in the SAME function call — so
# there is no window where cbm_process on another entity could read stale
# shared state. Per-entity tag = per-entity debounce, no cross-talk.
# ======================================================================================

# Snapshot first (TOCTOU safe)
data modify storage macroengine:input cbm.command set from storage macroengine:input _cbm.current
data modify storage macroengine:input cbm.source_uuid set from entity @s UUID
data modify storage macroengine:input cbm.pos set from entity @s Pos

# Mark pending BEFORE callback so a missing/never-running handler cannot spam
tag @s add macroengine.cbm_pending

# Clear temporary + entity Command immediately (single-use: consumed here
# regardless of whether a handler runs, so it never re-fires on this Command).
data remove storage macroengine:input _cbm
data modify entity @s Command set value ""

# Resolve player context (never leave @s as the minecart)
# Preferred: the player who summoned this CBM
execute as @a[tag=macroengine.cbm_owner,limit=1] at @s run function macroengine:player/get_name
execute as @a[tag=macroengine.cbm_owner,limit=1] at @s run function #macroengine:input/command_block_minecart

# Fallback (if tag was lost / old minecart): nearest player within 8 blocks
execute unless entity @a[tag=macroengine.cbm_owner] as @a[distance=..8,sort=nearest,limit=1] at @s run function macroengine:player/get_name
execute unless entity @a[tag=macroengine.cbm_owner] as @a[distance=..8,sort=nearest,limit=1] at @s run function #macroengine:input/command_block_minecart

# Release this entity's own debounce now that handling was attempted,
# and clear the shared cbm data this entity wrote.
tag @s remove macroengine.cbm_pending
data remove storage macroengine:input cbm