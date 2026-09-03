# ─────────────────────────────────────────────────────────────────
# macroengine:systems/nbt/append
# Appends an element from another storage path to a list in storage.
#
# INPUT (storage macroengine:input):
# dst_storage → destination storage
# dst_path → destination list path
# src_storage → source storage
# src_path → path of the value to append
# ─────────────────────────────────────────────────────────────────

function macroengine:core/internal/systems/nbt/append_exec with storage macroengine:input {}
