# ─────────────────────────────────────────────────────────────────
# macroengine:systems/nbt/exists
# Checks whether a specific path exists in storage.
#
# INPUT (storage macroengine:input):
# storage → storage namespace
# path → path to check
#
# OUTPUT: macroengine:output result → 1b (exists) or 0b (not found)
# ─────────────────────────────────────────────────────────────────

function macroengine:core/internal/systems/nbt/exists_exec with storage macroengine:input {}
