# RTWrapper core uninstall.
# Reverses everything core/load.mcfunction + core/meta_init.mcfunction set up.
# Safe to run even if RTWrapper was never loaded (all removes are unconditional
# and no-op on missing scoreboards/storage).

# Announce before state is torn down, since the debug gate itself is about to be removed.
execute if score #debug rtw.config matches 1.. run tellraw @a[tag=rtwrapper.debug] [{"text":"[RTWrapper] uninstalling: clearing storage and scoreboards","color":"gray"}]

# Drop storage roots owned by RTWrapper. `data remove storage <id>` with no path is
# invalid syntax; each top-level key set up by core/load.mcfunction / meta_init must be
# removed individually.
data remove storage rtwrapper:meta version
data remove storage rtwrapper:meta id
data remove storage rtwrapper:meta type
data remove storage rtwrapper:meta datapack_type
data remove storage rtwrapper:meta status
data remove storage rtwrapper:meta loaded
data remove storage rtwrapper:runtime config
data remove storage rtwrapper:runtime queue
data remove storage rtwrapper:runtime current
data remove storage rtwrapper:api request
data remove storage rtwrapper:api params
data remove storage rtwrapper:api batch

# Drop scoreboard objectives (also removes all #debug/#silent/#auto_tick/#processed/#errors entries).
scoreboard objectives remove rtw.config
scoreboard objectives remove rtw.status