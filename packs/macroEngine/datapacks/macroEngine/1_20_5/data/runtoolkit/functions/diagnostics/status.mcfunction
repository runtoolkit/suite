# runtoolkit:diagnostics/status
# Reports live loaded/disabled state for every registered subsystem,
# read straight from each subsystem's "#runtoolkit.packs.<name>.version"
# score — not from the registry snapshot, so this reflects reality even
# if a subsystem was disabled after registering (e.g. via its own
# disable command) without re-registering.

execute unless data storage runtoolkit:engine registry.subsystems[0] run tellraw @s ["",{"text":"[RUNTOOLKIT] ","color":"#00AAAA","bold":true},{"text":"no subsystems registered — nothing to report.","color":"gray"}]
execute unless data storage runtoolkit:engine registry.subsystems[0] run return 0

tellraw @s ["",{"text":"[RUNTOOLKIT] ","color":"#00AAAA","bold":true},{"text":"subsystem status:","color":"aqua"}]
data modify storage runtoolkit:tmp _walk set from storage runtoolkit:engine registry.subsystems
function runtoolkit:diagnostics/status_step
data remove storage runtoolkit:tmp _walk
