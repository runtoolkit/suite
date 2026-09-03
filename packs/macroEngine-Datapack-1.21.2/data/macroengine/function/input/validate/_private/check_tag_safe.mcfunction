# ======================================================================================
# macroengine:input/validate/_private/check_tag_safe  [INTERNAL]
# ======================================================================================
# Rejects empty strings and any string containing one of: space " ' { } [ ] :
# or a literal backslash. Safe result can be used as a scoreboard
# objective/player-name fragment or dropped unquoted into a single NBT
# string field without needing escaping.
#
# One macroengine:core/internal/string/util/find per forbidden character — fixed cost (9 calls),
# not per-character-of-input.
# ======================================================================================

execute store result score #macroengine.Len macroengine.tmp run data get storage macroengine:input_validate scratch.value
execute if score #macroengine.Len macroengine.tmp matches 0 run data modify storage macroengine:input_validate result.error set value "empty input"
execute if score #macroengine.Len macroengine.tmp matches 0 run return 0

data modify storage macroengine:core/internal/string/input find.String set from storage macroengine:input_validate scratch.value
data modify storage macroengine:core/internal/string/input find.n set value 1

data modify storage macroengine:input_validate scratch.bad set value 0b

function macroengine:input/validate/_private/reject_if_present {char:" "}
function macroengine:input/validate/_private/reject_if_present {char:"\""}
function macroengine:input/validate/_private/reject_if_present {char:"'"}
function macroengine:input/validate/_private/reject_if_present {char:"{"}
function macroengine:input/validate/_private/reject_if_present {char:"}"}
function macroengine:input/validate/_private/reject_if_present {char:"["}
function macroengine:input/validate/_private/reject_if_present {char:"]"}
function macroengine:input/validate/_private/reject_if_present {char:":"}
function macroengine:input/validate/_private/reject_if_present {char:"\\"}
function macroengine:input/validate/_private/reject_if_present {char:"§"}
function macroengine:input/validate/_private/reject_if_present {char:"|"}
function macroengine:input/validate/_private/reject_if_present {char:"^"}
function macroengine:input/validate/_private/reject_if_present {char:"<"}
function macroengine:input/validate/_private/reject_if_present {char:">"}

execute unless data storage macroengine:input_validate {scratch:{bad:1b}} run data modify storage macroengine:input_validate result.valid set value 1b
execute if data storage macroengine:input_validate {scratch:{bad:1b}} run data modify storage macroengine:input_validate result.error set value "contains a disallowed character (space, quote, brace, bracket, colon, or backslash)"

data remove storage macroengine:input_validate scratch.bad
