execute if data storage macroengine:engine pb_obj run scoreboard players operation $pb_mod macroengine.tmp = $epoch macroengine.time
execute if data storage macroengine:engine pb_obj run scoreboard players operation $pb_mod macroengine.tmp %= $pb_four macroengine.tmp
execute if data storage macroengine:engine pb_obj run execute if score $pb_mod macroengine.tmp matches 0 run execute as @a run function macroengine:systems/string/progress_bar_self with storage macroengine:engine {}

# experimental/scoreboard_hud — auto-hide if the flag was turned off
# while the HUD was showing, so disabling the flag actually removes it
# instead of leaving a stale sidebar.
execute if score #exp_hud_on macroengine.tmp matches 1 unless data storage macroengine:engine flags.experimental{scoreboard_hud:1b} run scoreboard objectives setdisplay sidebar
execute if score #exp_hud_on macroengine.tmp matches 1 unless data storage macroengine:engine flags.experimental{scoreboard_hud:1b} run scoreboard players set #exp_hud_on macroengine.tmp 0
