# AME Tick — Channel Execute [MACRO]
# Calls fn directly if condition is empty, otherwise checks predicate first.
# Input: $(fn), $(condition)
#
# condition:"" → always run (no predicate check)
# condition:"macro:is_daytime" → only run when predicate passes

execute if data storage macro:tick_work channel{condition:""} run return 0

$data modify storage macro:engine _dispatch.func set value "$(fn)"
$execute as @a[limit=1] at @s if predicate $(condition) run function #macro:internal/dispatch
