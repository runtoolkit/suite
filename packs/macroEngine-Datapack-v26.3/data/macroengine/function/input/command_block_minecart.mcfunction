# ======================================================================================
# macroengine:input/command_block_minecart
# ======================================================================================
#
# TRIGGERED BY: #macroengine:input/command_block_minecart function tag
#
# PURPOSE:
#   Reads the Command NBT off any command_block_minecart tagged 'macroengine_input',
#   dropped into the world via
#   'summon minecraft:command_block_minecart ~ ~ ~ {Tags:["macroengine_input"]}'.
#   CAPTURE ONLY — never executes the string itself.
#
# CALLBACK CONTRACT (register your handler in this tag's JSON):
#   Once your function is done reading macroengine:input cbm.command (and
#   cbm.pos / cbm.source_uuid if needed), it MUST end with:
#     data modify storage macroengine:input cbm.executed set value 1b
#   This is not optional bookkeeping — cbm_process/cbm_capture use
#   cbm.executed as the "has this been delivered yet" signal and will
#   refuse to re-scan a minecart's Command until it sees executed:1b. If
#   your handler never sets it (e.g. it defers work via `schedule` instead
#   of finishing synchronously here), that one minecart stays parked —
#   Command is not re-read — until something sets executed:1b. It will NOT
#   spam-process the same command every tick, and it will not silently
#   drop the captured data either.
#
# REWRITTEN based on Legends11's reference implementation (TunnelScript-1.20.1:
# tunnelscript_core:internal/minecart_scan + minecart_process + minecart_capture).
# Bugs fixed vs. the previous version:
#
#   BUG 1 — wrong emptiness check. Previous version used
#     'execute unless data entity @s Command run return 0'
#   which only checks whether the Command PATH exists, not whether its VALUE
#   is empty. A minecart with Command:"" (path present, value empty) passed
#   this check and was treated as real input — false positive capture. Fixed
#   by comparing the actual value, matching TunnelScript's
#   'execute unless data storage tunnelscript:minecart {current:""}'.
#
#   BUG 2 — killed the entity instead of clearing it. TunnelScript never
#   kills the minecart: it resets Command back to "" and keeps the entity
#   alive for reuse (this also matches the 'tunnelscript_input' tag used
#   elsewhere by Legends11 for the align/tp helper, which assumes the
#   minecart persists rather than being destroyed each capture). Fixed to
#   clear Command instead of killing @s.
#
#   BUG 3 — 'limit=1,sort=nearest' silently ignored every other tagged
#   minecart in the world. TunnelScript scans ALL tagged minecarts every
#   tick with a plain 'as @e[...]', no limit. Fixed to match.
#
#   BUG 4 — unconditional cleanup could wipe an undelivered capture.
#   cbm_capture used to end with an unconditional
#   'data remove storage macroengine:input cbm' right after firing this
#   tag. Since this tag ships empty ({"values": []}) until the caller
#   registers something in it, a callback that wasn't wired up yet, was
#   registered under the wrong namespace, or deferred its work via
#   `schedule` meant the capture was deleted before anything read it —
#   the call silently "collapsed" with no function ever actually running
#   on the data. Fixed by leaving cbm.command/cbm.pos/cbm.source_uuid in
#   storage until the caller explicitly marks cbm.executed:1b.
#
#   BUG 5 — fixing BUG 4 by simply no longer clearing storage reintroduced
#   spam: with Command cleared but macroengine:input cbm left untouched and
#   executed permanently stuck at 0b, nothing ever signaled "already
#   handled", so an unconsumed capture looked identical to a fresh one on
#   every following tick. Fixed with a per-entity debounce tag
#   (macroengine.cbm_pending, mirroring the pattern already used by
#   book/name_tag capture) that blocks Command from being re-scanned until
#   the caller sets executed:1b — see cbm_process.mcfunction and
#   cbm_capture.mcfunction for the mechanics.
#
# KNOWN LIMITATION (not fixed here — flag for Legends11): macroengine:input
# cbm is a single global storage path shared by every tagged minecart in
# the world. With multiple simultaneous command_block_minecarts, a second
# minecart's capture will overwrite cbm.command/pos/source_uuid while a
# first one is still pending, and cbm.executed:1b from handling the second
# will incorrectly release the debounce on the first as well (or vice
# versa depending on scan order within the tick). This rewrite assumes one
# active input minecart at a time, consistent with summon_cbm.mcfunction
# killing any existing tagged minecart within 2 blocks before summoning a
# new one. If concurrent minecarts across different players/locations are
# ever needed, cbm storage and the pending tag both need to become
# per-entity (e.g. keyed by UUID) rather than a single shared path.
#
# SECURITY NOTE (unchanged): whoever can summon this entity with a real
# Command value already has raw command-execution ability. This function
# transports that string into the datapack, it does not create the
# privilege — the real permission boundary is who can spawn a marked
# minecart at all.
# ======================================================================================

# Fast exit — nothing tagged, nothing to scan this tick.
execute unless entity @e[type=minecraft:command_block_minecart,tag=macroengine_input] run return 0

execute as @e[type=minecraft:command_block_minecart,tag=macroengine_input] run function macroengine:input/private/cbm_process
