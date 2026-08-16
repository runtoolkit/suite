# DL Tick — Channel Execute [MACRO]
# Calls fn directly if condition is empty, otherwise checks predicate first.
# Input: $(fn)
#
# condition:"" → always run (no predicate check)

$data modify storage macroengine:engine _dispatch.func set value "$(fn)"
execute if data storage macroengine:tick_work channel{condition:""} run function #macroengine:internal/dispatch