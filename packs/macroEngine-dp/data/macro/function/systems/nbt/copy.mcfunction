# ─────────────────────────────────────────────────────────────────
# macro:systems/nbt/copy
# Copies a path between two storages or within the same storage.
#
# INPUT (storage macro:input):
# src_storage → source storage namespace (e.g. "macro:engine")
# src_path → source NBT path (e.g. "players.Steve")
# dst_storage → destination storage namespace
# dst_path → destination NBT path
#
# EXAMPLE:
# data modify storage macro:input src_storage set value "macro:engine"
# data modify storage macro:input src_path set value "players.Steve"
# data modify storage macro:input dst_storage set value "mypack:data"
# data modify storage macro:input dst_path set value "backup.Steve"
# function macro:systems/nbt/copy
# ─────────────────────────────────────────────────────────────────

function macro:systems/nbt/internal/copy_exec with storage macro:input {}
