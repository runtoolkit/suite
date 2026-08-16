# runtoolkit:version
# Reports runtoolkit's own dispatcher-layer version — NOT any individual
# subsystem's version (use runtoolkit:diagnostics/status for that).
# This tracks the runtoolkit: namespace itself (load/tick entry points,
# registry, diagnostics, killswitch) as a unit, independent of which
# subsystems happen to be registered under it.
#
# Storage: runtoolkit:engine meta.version — set once here on every call
# (idempotent) rather than only at load, so it stays correct even if this
# file is edited and the datapack reloaded without a full load-tag pass.

data modify storage runtoolkit:engine meta.version set value "1.0.0"

tellraw @s ["",{"text":"[RUNTOOLKIT] ","color":"#00AAAA","bold":true},{"text":"dispatcher v","color":"aqua"},{"nbt":"meta.version","storage":"runtoolkit:engine","color":"white"}]
