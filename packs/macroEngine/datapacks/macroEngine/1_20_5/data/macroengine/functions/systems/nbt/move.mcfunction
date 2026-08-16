# ─────────────────────────────────────────────────────────────────
# macroengine:systems/nbt/move
# Moves a path within the same storage (copy + delete).
#
# INPUT (storage macroengine:input):
# storage → storage namespace
# from_path → source path
# to_path → destination path
# ─────────────────────────────────────────────────────────────────

function macroengine:core/internal/systems/nbt/move_exec with storage macroengine:input {}
