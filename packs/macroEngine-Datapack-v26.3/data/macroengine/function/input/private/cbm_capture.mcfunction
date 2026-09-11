# ======================================================================================
# macroengine:input/private/cbm_capture  [INTERNAL — do not call directly]
# ======================================================================================
#
# Only reached when cbm_process confirmed Command is non-empty. Runs with
# @s still bound to that minecart.
#
# TOCTOU note: snapshot into macroengine:input BEFORE clearing Command, so a
# later tick mutating the entity's NBT cannot change what we already
# captured this tick.
#
# Entity handling matches TunnelScript: Command is cleared back to "" so
# the minecart is reusable and is NOT killed. This also matches the
# 'tunnelscript_input' tag Legends11 uses elsewhere (cbm_align_tp), which
# assumes the tagged minecart persists in the world.
# ======================================================================================

# Snapshot raw command string as-is — no interpretation, no execution.
data modify storage macroengine:input cbm.command set from storage macroengine:input _cbm.current

data modify storage macroengine:input cbm.source_uuid set from entity @s UUID
data modify storage macroengine:input cbm.pos set from entity @s Pos

# "raw, unvalidated, unexecuted" — downstream (separate execution pack)
# macroengine:debug/tools/utils/input_check before ever treating it as
# runnable, and running it there stays optional, never mandatory.
#
# Separately, if a caller wants cbm.command as a number/bool/tag-safe
# literal (not as a runnable command), use macroengine:input/validate/check:
#   function macroengine:input/validate/check with storage <yourpath> {source:"cbm.command", type:"int"}
data modify storage macroengine:input cbm.executed set value 0b
execute if data storage macroengine:input cbm{executed:0b} run function #macroengine:input/command_block_minecart

# Reset entity state so the minecart is reusable — this is NOT
# the same thing as clearing the captured data. Fine to do unconditionally,
# whether or not #macroengine:input/command_block_minecart contained anything.
data remove storage macroengine:input _cbm
data modify entity @s Command set value ""

# BUG FIX: this used to end with 'data remove storage macroengine:input cbm'
# right here, unconditionally. #macroengine:input/command_block_minecart is a
# function TAG the caller populates themselves (it ships as {"values": []}).
# If the caller's registered function never actually ran synchronously inside
# that "execute if ... run function #tag" line above — empty tag, wrong
# namespace registered into it, or a callback that defers work via `schedule`
# instead of reading cbm.command immediately — the capture was wiped before
# anything ever consumed it. Every other input method (book, name_tag,
# lectern, sign, dialog) leaves its captured fields in macroengine:input
# untouched after firing its tag; cbm was the only one that didn't, which is
# why only this path could silently "collapse" a call that never fired.
#
# cbm.command / cbm.pos / cbm.source_uuid are now left in storage for the
# caller to read — consistent with every other input method's contract. If
# you want the field cleared after handling it, do that yourself, from
# inside the function you registered on #macroengine:input/command_block_minecart:
#   data remove storage macroengine:input cbm
