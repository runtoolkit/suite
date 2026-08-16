# ======================================================================================
# macroengine:input/validate/_private/count_digits [INTERNAL]
# ======================================================================================
# Requires scratch.rest to be set (the string to scan, already stripped of
# any leading sign/dot handling by the caller). Sets score
# #macroengine.DigitCount macroengine.tmp to the total number of '0'-'9' characters found
# in scratch.rest, using macroengine_string:util/find once per digit.
#
# Note on cost: this is 10 macroengine_string:util/find calls regardless of input
# length — flat cost, not per-character — which is what makes it cheap
# next to a recursive char-walk.
# ======================================================================================

scoreboard players set #macroengine.DigitCount macroengine.tmp 0

data modify storage macroengine_string:input find.String set from storage macroengine:input_validate scratch.rest
data modify storage macroengine_string:input find.n set value 0

function macroengine:input/validate/_private/count_one_digit {digit:"0"}
function macroengine:input/validate/_private/count_one_digit {digit:"1"}
function macroengine:input/validate/_private/count_one_digit {digit:"2"}
function macroengine:input/validate/_private/count_one_digit {digit:"3"}
function macroengine:input/validate/_private/count_one_digit {digit:"4"}
function macroengine:input/validate/_private/count_one_digit {digit:"5"}
function macroengine:input/validate/_private/count_one_digit {digit:"6"}
function macroengine:input/validate/_private/count_one_digit {digit:"7"}
function macroengine:input/validate/_private/count_one_digit {digit:"8"}
function macroengine:input/validate/_private/count_one_digit {digit:"9"}
