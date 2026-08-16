forceload add 0 0

data modify storage macroengine:input func set value "macroengine:core/lib/sync_tick"
data modify storage macroengine:input interval set value 20
data modify storage macroengine:input key set value "sync_tick"
function macroengine:core/lib/schedule with storage macroengine:input {}
data remove storage macroengine:input func
data remove storage macroengine:input interval
data remove storage macroengine:input key

scoreboard players enable @a[tag=macroengine.admin] macroengine_menu
scoreboard players enable @a[tag=macroengine.admin] macroengine_run
scoreboard players enable @a[tag=macroengine.admin] macroengine_action

# Initialize tick channel config on first world load
function macroengine:core/tick/init_channels

# Assign pid for any players already online at load time
# (on_player_join won't fire for them after a /reload)
execute as @a run function macroengine:core/internal/player/init_online
