# ─────────────────────────────────────────────────────────────────
# macro:systems/nbt/append
# Appends an element from another storage path to a list in storage.
#
# INPUT (storage macro:input):
# dst_storage → destination storage
# dst_path → destination list path
# src_storage → source storage
# src_path → path of the value to append
# ─────────────────────────────────────────────────────────────────

function macro:systems/nbt/internal/append_exec with storage macro:input {}
