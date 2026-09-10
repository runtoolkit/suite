# ======================================================================================
# macroengine:input/validate/_private/check_float_dot_position  [INTERNAL]
# ======================================================================================
# macroengine:core/internal/string/output find holds a one-element list [idx] for the '.' just
# located by check_float. Rejects idx == 0 (leading dot, e.g. ".5") and
# idx == len-1 (trailing dot, e.g. "1.") as malformed rather than
# guessing an implied leading/trailing zero.
# ======================================================================================

execute store result score #macroengine.DotIdx macroengine.tmp run data get storage macroengine:core/internal/string/output find[0]
execute store result score #macroengine.Len macroengine.tmp run data get storage macroengine:input_validate scratch.rest

scoreboard players operation #macroengine.LastIdx macroengine.tmp = #macroengine.Len macroengine.tmp
scoreboard players remove #macroengine.LastIdx macroengine.tmp 1

execute if score #macroengine.DotIdx macroengine.tmp matches 0 run data modify storage macroengine:input_validate result.error set value "malformed decimal point"
execute if score #macroengine.DotIdx macroengine.tmp = #macroengine.LastIdx macroengine.tmp run data modify storage macroengine:input_validate result.error set value "malformed decimal point"
