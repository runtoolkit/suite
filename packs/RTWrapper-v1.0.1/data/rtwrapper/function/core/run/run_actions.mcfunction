# Immediate drain mode: processes a direct request or queued requests until the queue is empty.
# Do not use this from the tick loop; autotick uses core/run/run_next to process one action per tick.
# # # Silent mode suppresses RTWrapper's own tellraw debug/status messages. It does not
# permanently change vanilla gamerules.
#
# Bug fix (v1.0.0): this used to re-invoke itself directly with
# `execute if ... run function rtwrapper:core/run/run_actions`. Each such call nests inside
# the current command chain, so a long queue (deep enough to exceed the server's command
# chain length) could exhaust the chain and abort the drain partway through with the queue
# left non-empty. `schedule ... 1t replace` instead queues the next drain step as a fresh,
# unnested call, so chain depth no longer grows with queue length and an arbitrarily long
# queue can no longer overflow it.
#
# Trade-off to be aware of: this makes the drain resume on the *next* server tick rather
# than guaranteeing completion within the current one, so "immediate drain" is no longer
# strictly same-tick for very long queues (it was already effectively bounded by the chain
# limit before this fix, just via a crash instead of a controlled continuation). For queues
# short enough to never have hit the chain limit, behavior is unchanged.
# # execute if score #debug rtw.config matches 1.. if score #silent rtw.config matches 0 run tellraw @a[tag=rtwrapper.debug] [{"text":"[RTWrapper] run_actions drain","color":"gold"}]
function rtwrapper:core/wrappers/handler/main
execute if data storage rtwrapper:runtime queue[0] run schedule function rtwrapper:core/run/run_actions 1t replace
