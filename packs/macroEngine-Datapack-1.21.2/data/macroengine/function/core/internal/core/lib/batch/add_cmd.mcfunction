# macroengine:core/lib/batch/internal/add_cmd [MACRO]
# INPUT: $(id) — cmd is NBT-copied from macroengine:input, not macro-spliced
# Called with cmd field guaranteed.

$data modify storage macroengine:engine batches.$(id).items append value {cmd:""}
$data modify storage macroengine:engine batches.$(id).items[-1].cmd set from storage macroengine:input cmd
