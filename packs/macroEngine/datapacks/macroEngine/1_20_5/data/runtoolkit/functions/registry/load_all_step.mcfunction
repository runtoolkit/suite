# runtoolkit:registry/load_all_step
# Internal recursive walker for registry/load_all. For each seed entry:
# 1. Call its load_fn (the subsystem's own load chain).
# 2. Read its live version score (only valid AFTER step 1 — the
#    subsystem's own load chain is what sets that score, e.g.
#    macroengine:config sets #runtoolkit.packs.macroengine.version).
# 3. Call registry/register with that live version, so the registry
#    entry is never stale by construction.

execute unless data storage runtoolkit:tmp _load_walk[0] run return 0

data modify storage runtoolkit:tmp _load_entry set from storage runtoolkit:tmp _load_walk[0]
function runtoolkit:registry/load_all_dispatch with storage runtoolkit:tmp _load_entry
data remove storage runtoolkit:tmp _load_entry

data remove storage runtoolkit:tmp _load_walk[0]
function runtoolkit:registry/load_all_step
