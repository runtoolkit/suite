# ======================================================================================
# macroengine:input/validate/_private/reject_if_present  [INTERNAL — macro function]
# ======================================================================================
# Called with {char: "<single char>"}. macroengine_string:input find.String and
# find.n are already set by the caller. Sets scratch.bad = 1b if this
# character occurs anywhere.
#
# NOTE: unlike count_one_digit, this is a presence check, not a count —
# find()'s own return value (1 if found, fail if not — see find.mcfunction's
# final line) is exactly what a presence check needs, so store success
# is used deliberately here rather than reading the output list.
# ======================================================================================

$data modify storage macroengine_string:input find.Find set value "$(char)"

execute store success score #macroengine.FindOk macroengine.tmp run function macroengine_string:util/find

execute if score #macroengine.FindOk macroengine.tmp matches 1 run data modify storage macroengine:input_validate scratch.bad set value 1b
