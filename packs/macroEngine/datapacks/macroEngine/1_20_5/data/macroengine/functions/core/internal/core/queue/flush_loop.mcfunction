# macroengine:core/queue/internal/flush_loop
# Drains the entire work_queue in one call stack (used by queue/flush).
# Recursion depth = queue size — do NOT call on large queues.

execute unless data storage macroengine:engine work_queue[0] run return 0
function macroengine:core/internal/core/queue/exec_next
function macroengine:core/internal/core/queue/flush_loop
