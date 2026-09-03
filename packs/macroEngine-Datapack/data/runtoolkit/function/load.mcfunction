# runtoolkit global entry point — load
# Dispatches to every subsystem listed in runtoolkit:registry/seed (a
# static, hand-maintained list — this is the ONLY place a subsystem's
# load_fn is hardcoded now; see registry/seed.mcfunction to add one).

# Ensure runtoolkit's own scratch objective exists. Missing this made every
# runtoolkit:* function that reads/writes "runtoolkit.tmp" fail silently
# (score get/store on a nonexistent objective does nothing, no error) —
# this is what broke registry/list, diagnostics/status and killswitch/all.
scoreboard objectives add runtoolkit.tmp dummy

function runtoolkit:registry/load_all