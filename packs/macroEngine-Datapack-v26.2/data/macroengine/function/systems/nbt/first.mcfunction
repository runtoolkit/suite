# ─────────────────────────────────────────────────────────────────
# macroengine:systems/nbt/first
# Copies the first element [0] of a list at src_path into dst_path.
# If the list is empty or path does not exist, does nothing (silent fail).
#
# INPUT (storage macroengine:input):
# src_storage → source storage namespace
# src_path → list path (element [0] will be read)
# dst_storage → destination storage namespace
# dst_path → destination path to write into
#
# EXAMPLE:
# data modify storage macroengine:input src_storage set value "macroengine:engine"
# data modify storage macroengine:input src_path set value "event_queue"
# data modify storage macroengine:input dst_storage set value "macroengine:output"
# data modify storage macroengine:input dst_path set value "result"
# function macroengine:systems/nbt/first
# ─────────────────────────────────────────────────────────────────

function macroengine:core/internal/systems/nbt/first_exec with storage macroengine:input {}
