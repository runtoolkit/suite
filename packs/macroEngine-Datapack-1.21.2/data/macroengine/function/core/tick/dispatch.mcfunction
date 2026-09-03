# DL Tick — Simplified Dispatch (no runtime channel registry)
# Rate/offset is fixed here instead of a JSON-configurable list.
# Each system can be toggled on/off via a scoreboard flag (default 1 = on),
# set with: function macroengine:systems/flag/toggle_system {system:"time"}
# Valid system ids: time | player | queue | hud | admin
#
# time_systems / player_systems / queue_systems: every tick (rate 1)
# hud_systems: every 2 ticks
# admin_systems: every 4 ticks
scoreboard players add #tick_ctr macroengine.tick 1

execute unless score #sys_time macroengine.tick_flags matches 0 run function macroengine:core/tick/time_systems
execute unless score #sys_player macroengine.tick_flags matches 0 run function macroengine:core/tick/player_systems
execute unless score #sys_queue macroengine.tick_flags matches 0 run function macroengine:core/tick/queue_systems

scoreboard players operation #hud_mod macroengine.tick = #tick_ctr macroengine.tick
scoreboard players set #hud_rate macroengine.tick 2
scoreboard players operation #hud_mod macroengine.tick %= #hud_rate macroengine.tick
execute if score #hud_mod macroengine.tick matches 0 unless score #sys_hud macroengine.tick_flags matches 0 run function macroengine:core/tick/hud_systems

scoreboard players operation #admin_mod macroengine.tick = #tick_ctr macroengine.tick
scoreboard players set #admin_rate macroengine.tick 4
scoreboard players operation #admin_mod macroengine.tick %= #admin_rate macroengine.tick
execute if score #admin_mod macroengine.tick matches 0 unless score #sys_admin macroengine.tick_flags matches 0 run function macroengine:core/tick/admin_systems
