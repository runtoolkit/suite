# macro:core/queue/internal/exec_fn
# Runs a queued function in server (non-entity) context.
# Called with storage macro:engine _wq_job as macro source.
#
# Macro input:
#   fn — function path to call

$data modify storage macro:engine _dispatch.func set value "$(fn)"
function #macro:internal/dispatch
