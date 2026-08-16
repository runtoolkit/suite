# runtoolkit:registry/register
# Called once by a subsystem (e.g. macroengine_load:main) to announce itself
# to runtoolkit's dispatcher. Idempotent: re-running with the same name
# overwrites that entry instead of duplicating it, so a /reload doesn't
# grow the list.
#
# MACRO INPUT:
#   $(name)       -> subsystem id, e.g. "macroengine"
#   $(version)    -> int, mirrors #runtoolkit.packs.<name>.version
#   $(load_fn)    -> function id dispatched on minecraft:load, e.g. "macroengine_load:main"
#   $(tick_fn)    -> function id dispatched on minecraft:tick, e.g. "macroengine.main:macroengine/tick"
#   $(disable_fn) -> function id that cleanly disables this subsystem, e.g. "macroengine:disable"
#                    (used by runtoolkit:killswitch/all — must be the subsystem's public,
#                    gated entry point, not an internal /apply function, so the
#                    subsystem's own confirmation/sandbox behavior is respected)
#
# NOTE: this only records metadata for registry/list and diagnostics/status.
# It does NOT hook the subsystem into minecraft:load / minecraft:tick —
# that still happens via data/minecraft/tags/function/{load,tick}.json,
# same as today. Registration is descriptive, not wiring.

execute unless data storage runtoolkit:engine registry run data modify storage runtoolkit:engine registry set value {}
execute unless data storage runtoolkit:engine registry.subsystems run data modify storage runtoolkit:engine registry.subsystems set value []

$data modify storage runtoolkit:tmp entry set value {name:"$(name)",version:$(version),load_fn:"$(load_fn)",tick_fn:"$(tick_fn)",disable_fn:"$(disable_fn)"}

# Remove any existing entry with this name (re-registration on reload), then append fresh.
$data remove storage runtoolkit:engine registry.subsystems[{name:"$(name)"}]
data modify storage runtoolkit:engine registry.subsystems append from storage runtoolkit:tmp entry
data remove storage runtoolkit:tmp entry

$tellraw @a[tag=macroengine.debug] ["",{"text":"[RUNTOOLKIT] ","color":"#00AAAA","bold":true},{"text":"registry/register ","color":"aqua"},{"text":"→ ","color":"#555555"},{"text":"$(name)","color":"white"},{"text":" v","color":"#555555"},{"text":"$(version)","color":"green"}]
