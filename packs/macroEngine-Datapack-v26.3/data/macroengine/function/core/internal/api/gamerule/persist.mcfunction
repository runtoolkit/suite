# macroengine:api/gamerule/internal/persist [MACRO]
# Writes the normalized rule name + value into macroengine:engine gamerules compound.
# Called exclusively by macroengine:api/gamerule/set — do NOT call directly.
#
# INPUT (macro args via `with storage macroengine:input {}`):
#   $(_gamerule_norm) — normalized rule name (spaces → underscores, lowercase)
#   $(value)          — value string

$data modify storage macroengine:engine gamerules.$(_gamerule_norm) set value "$(value)"
