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

# Initialize tick system on/off flags on first world load (idempotent —
# "unless matches .." only true when score is unset, so this never
# overwrites a runtime toggle made via flag/toggle_system)
execute unless score #sys_time macroengine.tick_flags matches 1.. run scoreboard players set #sys_time macroengine.tick_flags 1
execute unless score #sys_player macroengine.tick_flags matches 1.. run scoreboard players set #sys_player macroengine.tick_flags 1
execute unless score #sys_queue macroengine.tick_flags matches 1.. run scoreboard players set #sys_queue macroengine.tick_flags 1
execute unless score #sys_hud macroengine.tick_flags matches 1.. run scoreboard players set #sys_hud macroengine.tick_flags 1
execute unless score #sys_admin macroengine.tick_flags matches 1.. run scoreboard players set #sys_admin macroengine.tick_flags 1

# Assign pid for any players already online at load time
# (on_player_join won't fire for them after a /reload)
execute as @a run function macroengine:core/internal/player/init_online
