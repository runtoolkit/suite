# ─────────────────────────────────────────────────────────────────
# macro:systems/nbt/move
# Moves a path within the same storage (copy + delete).
#
# INPUT (storage macro:input):
# storage → storage namespace
# from_path → source path
# to_path → destination path
# ─────────────────────────────────────────────────────────────────

function macro:systems/nbt/internal/move_exec with storage macro:input {}
