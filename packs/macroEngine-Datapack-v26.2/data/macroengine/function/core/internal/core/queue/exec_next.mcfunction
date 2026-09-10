# macroengine:core/queue/internal/exec_next
# Pops work_queue[0] into _wq_job, removes it from the list,
# then dispatches to the appropriate runner.
# player field present → execute as that player (skipped if offline).
# player field absent  → run in server context.

data modify storage macroengine:engine _wq_job set from storage macroengine:engine work_queue[0]
data remove storage macroengine:engine work_queue[0]

execute if data storage macroengine:engine _wq_job.player run function macroengine:core/internal/core/queue/exec_as with storage macroengine:engine _wq_job
execute unless data storage macroengine:engine _wq_job.player run function macroengine:core/internal/core/queue/exec_fn with storage macroengine:engine _wq_job

data remove storage macroengine:engine _wq_job
