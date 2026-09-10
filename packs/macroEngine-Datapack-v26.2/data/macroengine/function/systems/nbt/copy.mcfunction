# ─────────────────────────────────────────────────────────────────
# macroengine:systems/nbt/copy
# Copies a path between two storages or within the same storage.
#
# INPUT (storage macroengine:input):
# src_storage → source storage namespace (e.g. "macroengine:engine")
# src_path → source NBT path (e.g. "players.Steve")
# dst_storage → destination storage namespace
# dst_path → destination NBT path
#
# EXAMPLE:
# data modify storage macroengine:input src_storage set value "macroengine:engine"
# data modify storage macroengine:input src_path set value "players.Steve"
# data modify storage macroengine:input dst_storage set value "mypack:data"
# data modify storage macroengine:input dst_path set value "backup.Steve"
# function macroengine:systems/nbt/copy
# ─────────────────────────────────────────────────────────────────

function macroengine:core/internal/systems/nbt/copy_exec with storage macroengine:input {}
