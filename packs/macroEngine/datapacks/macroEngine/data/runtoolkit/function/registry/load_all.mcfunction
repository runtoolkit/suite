# runtoolkit:registry/load_all
# Called from runtoolkit:load. Walks the static seed (registry/seed),
# calling each subsystem's load_fn and then registering it with the live
# registry — replacing the old hardcoded "function macroengine_load:main"
# + duplicate load_fn string that used to live directly in load.mcfunction.

function runtoolkit:registry/seed
data modify storage runtoolkit:tmp _load_walk set from storage runtoolkit:tmp seed
data remove storage runtoolkit:tmp seed
function runtoolkit:registry/load_all_step
data remove storage runtoolkit:tmp _load_walk
