# ======================================================================================
# macroengine:input/validate/_private/count_one_digit  [INTERNAL — macro function]
# ======================================================================================
# Called with {digit: "0".."9"}. macroengine_string:input find.String is assumed
# already set by the caller (count_digits) to the string being scanned —
# reused here as replace.String too.
#
# Uses macroengine_string:util/replace(Find:"<digit>", Replace:"") instead of
# macroengine_string:util/find, because replace()'s return value is a genuine
# running match count (see zprivate/replace/*.mcfunction: ReturnValue is
# incremented once per match). find()'s own return value is NOT a count —
# it's "execute if data storage macroengine_string:output find[]", which is just
# 1-or-fail regardless of how many indices are in the list. replace()
# gives the real number directly, with no separate list-length step
# needed, and its side effect (macroengine_string:output replace) is harmless here
# since count_digits never reads that key.
# ======================================================================================

data modify storage macroengine_string:input replace.String set from storage macroengine_string:input find.String
$data modify storage macroengine_string:input replace.Find set value "$(digit)"
data modify storage macroengine_string:input replace.Replace set value ""
data modify storage macroengine_string:input replace.n set value 0

scoreboard players set #macroengine.FindHits macroengine.tmp 0
execute store result score #macroengine.FindHits macroengine.tmp run function macroengine_string:util/replace

scoreboard players operation #macroengine.DigitCount macroengine.tmp += #macroengine.FindHits macroengine.tmp
