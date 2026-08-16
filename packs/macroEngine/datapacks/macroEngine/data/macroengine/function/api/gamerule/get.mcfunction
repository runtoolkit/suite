# macroengine:api/gamerule/get [MACRO]
# Reads a custom gamerule value from storage into macroengine:output gamerule.
#
# INPUT (macro args via `with storage macroengine:input {}`):
#   $(rule) — rule name string (must match the name used in set)
#
# OUTPUT:
#   macroengine:output gamerule — the stored value string, or absent if never set
#
# EXAMPLE:
#   data modify storage macroengine:input rule set value "pvp_enabled"
#   function macroengine:api/gamerule/get with storage macroengine:input {}
#   # read: data get storage macroengine:output gamerule


# Normalize key (spaces → underscores, lowercase)
data modify storage macroengine_string:input replace.String set from storage macroengine:input rule
data modify storage macroengine_string:input replace.Find set value " "
data modify storage macroengine_string:input replace.Replace set value "_"
function macroengine_string:util/replace
data modify storage macroengine_string:input to_lowercase.String set from storage macroengine_string:output replace
data remove storage macroengine_string:input replace
function macroengine_string:util/to_lowercase/fast
data modify storage macroengine:input _gamerule_norm set from storage macroengine_string:output to_lowercase

# Read from engine storage
data remove storage macroengine:output gamerule
function macroengine:core/internal/api/gamerule/read with storage macroengine:input {}

# $(_gamerule_norm) below is a NEW macro invocation's arg, bound at call time
# from current storage — NOT the same binding as this function's own $(rule)
# arg (which was fixed at entry, before _gamerule_norm existed). Calling this
# inline as a bare $tellraw would have silently failed to resolve.
function macroengine:core/internal/api/gamerule/debug_print with storage macroengine:input {}

data remove storage macroengine:input _gamerule_norm
