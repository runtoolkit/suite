# ─────────────────────────────────────────────────────────────────
# macro:systems/nbt/pop
# Copies the first element of a list to macro:output result and removes it.
#
# INPUT (storage macro:input):
# storage → storage namespace
# path → list path
#
# OUTPUT: macro:output result (popped element)
# ─────────────────────────────────────────────────────────────────

function macro:systems/nbt/internal/pop_exec with storage macro:input {}
