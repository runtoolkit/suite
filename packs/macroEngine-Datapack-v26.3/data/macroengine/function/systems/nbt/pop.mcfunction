# ─────────────────────────────────────────────────────────────────
# macroengine:systems/nbt/pop
# Copies the first element of a list to macroengine:output result and removes it.
#
# INPUT (storage macroengine:input):
# storage → storage namespace
# path → list path
#
# OUTPUT: macroengine:output result (popped element)
# ─────────────────────────────────────────────────────────────────

function macroengine:core/internal/systems/nbt/pop_exec with storage macroengine:input {}
