# Drain rtwrapper:runtime queue and any direct rtwrapper:api request immediately:
# process one action via run_next, then recurse while work remains. Used by
# api/run.mcfunction and api/run_batch.mcfunction for immediate (non-autotick)
# execution. Does not throttle — use core/run/run_next from autotick instead.
execute if data storage rtwrapper:runtime queue[0] run function rtwrapper:core/run/run_next
execute unless data storage rtwrapper:runtime queue[0] if data storage rtwrapper:api request.cmd run function rtwrapper:core/run/run_next
execute unless data storage rtwrapper:runtime queue[0] unless data storage rtwrapper:api request.cmd if data storage rtwrapper:api request.type run function rtwrapper:core/run/run_next

execute if data storage rtwrapper:runtime queue[0] run function rtwrapper:core/run/run_actions
execute unless data storage rtwrapper:runtime queue[0] if data storage rtwrapper:api request.cmd run function rtwrapper:core/run/run_actions
execute unless data storage rtwrapper:runtime queue[0] unless data storage rtwrapper:api request.cmd if data storage rtwrapper:api request.type run function rtwrapper:core/run/run_actions
