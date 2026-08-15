# Read-only queue inspection: reports the next queued action's cmd (and queue[0] existence)
# WITHOUT consuming it — unlike run_next/run_actions this never dequeues or dispatches.
# Useful for a dependent pack that wants to check what's about to run before draining.
execute unless data storage rtwrapper:runtime queue[0] run tellraw @s [{"text":"[RTWrapper] queue empty","color":"gray"}]
execute if data storage rtwrapper:runtime queue[0].cmd run tellraw @s [{"text":"[RTWrapper] next: ","color":"gold"},{"nbt":"queue[0].cmd","storage":"rtwrapper:runtime","color":"white"}]
execute if data storage rtwrapper:runtime queue[0] unless data storage rtwrapper:runtime queue[0].cmd if data storage rtwrapper:runtime queue[0].type run tellraw @s [{"text":"[RTWrapper] next: ","color":"gold"},{"nbt":"queue[0].type","storage":"rtwrapper:runtime","color":"white"}]
