# macroengine:core/lib/batch/internal/flush_queue_func [MACRO]
# INPUT: $(delay) — func is NBT-copied from _bfl_cur, not macro-spliced

$data modify storage macroengine:engine queue append value {func:"", delay:$(delay)}
data modify storage macroengine:engine queue[-1].func set from storage macroengine:engine _bfl_cur.func
