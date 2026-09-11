# ======================================================================================
# macroengine:input/private/cbm_process  [INTERNAL — do not call directly]
# ======================================================================================
#
# Runs with @s bound to a single tagged command_block_minecart. Reads its
# Command NBT into scratch storage, then only proceeds to capture if the
# value is a REAL non-empty string — matching TunnelScript's
# 'execute unless data storage tunnelscript:minecart {current:""}' check,
# not just a path-existence check.
#
# BUG FIX (spam): Command alone is not a reliable "new input" signal.
# cbm_capture clears Command back to "" once it captures, but the actual
# hand-off to the caller happens through the #macroengine:input/command_block_minecart
# tag — a callback the caller registers themselves. If that callback does
# not run synchronously inside cbm_capture's "execute if ... run function
# #tag" line (empty tag, wrong namespace, or work deferred via `schedule`),
# the write to macroengine:input cbm and the clearing of Command are the
# ONLY two things that happened that tick. Nothing marks the capture as
# delivered. Every subsequent tick before the entity resets Command again
# re-reads the same already-captured macroengine:input cbm contents as if
# it were fresh, because nothing ever gated on "did anyone actually consume
# this yet" — hence the same command getting processed over and over.
#
# Fix: gate on a per-entity debounce tag, the same pattern already used by
# every other input method (macroengine.book_captured, macroengine.name_tag_captured).
# 'macroengine.cbm_pending' means "captured, waiting on the caller to mark
# cbm.executed:1b". While pending, this minecart is skipped entirely —
# Command changes are ignored until the pending capture is resolved, so a
# callback that never fires can no longer cause repeat processing; it just
# leaves that one minecart parked until the caller either consumes it or
# re-tags the entity itself.
# ======================================================================================

# A capture is pending delivery on this minecart. Check whether the caller
# has marked it consumed (cbm.executed:1b) — if so, release the debounce so
# this minecart can capture again; if not, it's still awaiting the caller,
# so skip re-processing Command entirely (this is what stops the spam).
execute if entity @s[tag=macroengine.cbm_pending] if data storage macroengine:input cbm{executed:1b} run tag @s remove macroengine.cbm_pending
execute if entity @s[tag=macroengine.cbm_pending] run return 0

data modify storage macroengine:input _cbm.current set from entity @s Command

# Compare the actual VALUE to "" — a compound match, not a path-existence
# check. This is the fix for the false-positive-on-empty-Command bug.
execute unless data storage macroengine:input {_cbm:{current:""}} run function macroengine:input/private/cbm_capture
