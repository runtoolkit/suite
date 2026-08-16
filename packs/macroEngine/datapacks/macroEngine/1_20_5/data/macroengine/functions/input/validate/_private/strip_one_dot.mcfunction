# ======================================================================================
# macroengine:input/validate/_private/strip_one_dot [INTERNAL]
# ======================================================================================
# Removes exactly one '.' from scratch.rest (already confirmed to contain
# exactly one, at a valid non-edge position) via macroengine_string:util/replace,
# leaving the digit characters ready for count_digits.
# ======================================================================================

data modify storage macroengine_string:input replace.String set from storage macroengine:input_validate scratch.rest
data modify storage macroengine_string:input replace.Find set value "."
data modify storage macroengine_string:input replace.Replace set value ""
data modify storage macroengine_string:input replace.n set value 1

function macroengine_string:util/replace
data modify storage macroengine:input_validate scratch.rest set from storage macroengine_string:output replace
