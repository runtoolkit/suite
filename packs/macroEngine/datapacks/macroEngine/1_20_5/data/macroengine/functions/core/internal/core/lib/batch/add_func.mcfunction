# macroengine:core/lib/batch/internal/add_func [MACRO]
# INPUT: $(id) — func is NBT-copied from macroengine:input, not macro-spliced
# Called with func field guaranteed.

$data modify storage macroengine:engine batches.$(id).items append value {func:""}
$data modify storage macroengine:engine batches.$(id).items[-1].func set from storage macroengine:input func
