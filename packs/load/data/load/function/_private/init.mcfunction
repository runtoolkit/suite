# RunLoad — init
# Resets all load.status scores so each pack can set accurate values for the current reload.
scoreboard objectives add load.status dummy
scoreboard players reset * load.status

# RunLoad version: other packs can check  "RunLoad load.status matches 1.."
scoreboard players set RunLoad load.status 1

# Reload-flag objective: tracks whether this is the first-ever load or a manual /reload.
scoreboard objectives add load.init dummy

# Fire #load:reload only on manual /reload (not on first world load).
# On the very first load, load.init for #runload is 0 (absent) → skip reload tag, set flag to 1.
# On every subsequent load the flag is already 1 → fire #load:reload.
execute if score #runload load.init matches 1.. run function load:_private/reload
scoreboard players set #runload load.init 1
