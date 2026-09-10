# ─────────────────────────────────────────────────────────────────
# macroengine:systems/nbt/merge
# Merges a compound from src_storage:src_path into dst_storage:dst_path.
# Equivalent to: data modify <dst> merge from <src>
# Existing keys in dst are overwritten by src values; missing keys added.
#
# INPUT (storage macroengine:input):
# src_storage → source storage namespace (e.g. "macroengine:engine")
# src_path → source compound path
# dst_storage → destination storage namespace
# dst_path → destination compound path
#
# EXAMPLE:
# data modify storage macroengine:input src_storage set value "macroengine:engine"
# data modify storage macroengine:input src_path set value "players.Steve"
# data modify storage macroengine:input dst_storage set value "mypack:data"
# data modify storage macroengine:input dst_path set value "backup.Steve"
# function macroengine:systems/nbt/merge
# ─────────────────────────────────────────────────────────────────

function macroengine:core/internal/systems/nbt/merge_exec with storage macroengine:input {}
