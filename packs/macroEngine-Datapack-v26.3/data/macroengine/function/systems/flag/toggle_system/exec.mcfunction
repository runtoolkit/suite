# [MACRO] Internal exec for flag/toggle_system
# Input: $(system) — one of time | queue | player | hud | admin

$execute if score #sys_$(system) macroengine.tick_flags matches 1 run scoreboard players set #sys_$(system) macroengine.tick_flags 0
$execute if score #sys_$(system) macroengine.tick_flags matches 0 run scoreboard players set #sys_$(system) macroengine.tick_flags 1
