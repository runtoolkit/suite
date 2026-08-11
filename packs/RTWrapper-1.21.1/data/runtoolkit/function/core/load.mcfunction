# Runtoolkit shared loaded-pack registry bootstrap.
# Ensures runtoolkit:meta is initialized once. The registry itself needs no per-load action
# here: each participating datapack's own advancement (parented to runtoolkit:root, see
# docs/API.md "Runtoolkit loaded-pack registry") uses a minecraft:tick criterion, which the
# game checks automatically for every online player without a `advancement grant` call.
# This registry is visual-only: advancements are granted automatically and never revoked.
execute unless data storage runtoolkit:meta {loaded:1b} run data modify storage runtoolkit:meta loaded set value 1b
