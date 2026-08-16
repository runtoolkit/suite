# runtoolkit:killswitch/all
# Global emergency stop: disables every registered subsystem via its own
# public disable entry point (respecting each subsystem's own gate/
# confirmation behavior — this is a supervised shutdown, not a raw
# `datapack disable` sweep). Intended for admin use when something is
# misbehaving and you don't have time to disable subsystems one by one.
#
# Requires op / permission level enforced by the command tree this is
# wired into (not enforced here — see macroengine's own security.* config
# for the pattern this project follows: gating lives at the command-tree
# layer, not duplicated inside every function).

execute unless data storage runtoolkit:engine registry.subsystems[0] run tellraw @s ["",{"text":"[RUNTOOLKIT] ","color":"#00AAAA","bold":true},{"text":"no subsystems registered — nothing to stop.","color":"gray"}]
execute unless data storage runtoolkit:engine registry.subsystems[0] run return 0

tellraw @a ["",{"text":"[RUNTOOLKIT] ","color":"#00AAAA","bold":true},{"text":"KILLSWITCH — disabling all registered subsystems.","color":"red","bold":true}]
data modify storage runtoolkit:tmp _walk set from storage runtoolkit:engine registry.subsystems
function runtoolkit:killswitch/all_step
data remove storage runtoolkit:tmp _walk
tellraw @a ["",{"text":"[RUNTOOLKIT] ","color":"#00AAAA","bold":true},{"text":"killswitch complete.","color":"red"}]
