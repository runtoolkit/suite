# macroengine:world/time_phase — 26.3 World Clocks
execute store result score $tp_t macroengine.tmp run time query minecraft:day
execute store result storage macroengine:output daytime int 1 run scoreboard players get $tp_t macroengine.tmp
data modify storage macroengine:output is_day set value 0b
data modify storage macroengine:output is_night set value 0b
data modify storage macroengine:output is_dawn set value 0b
data modify storage macroengine:output is_dusk set value 0b
execute if score $tp_t macroengine.tmp matches 0..12999 run data modify storage macroengine:output is_day set value 1b
execute if score $tp_t macroengine.tmp matches 13000..23999 run data modify storage macroengine:output is_night set value 1b
execute if score $tp_t macroengine.tmp matches 0..999 run data modify storage macroengine:output is_dawn set value 1b
execute if score $tp_t macroengine.tmp matches 12000..13799 run data modify storage macroengine:output is_dusk set value 1b
execute if score $tp_t macroengine.tmp matches 0..999 run data modify storage macroengine:output phase set value "dawn"
execute if score $tp_t macroengine.tmp matches 1000..11999 run data modify storage macroengine:output phase set value "day"
execute if score $tp_t macroengine.tmp matches 12000..13799 run data modify storage macroengine:output phase set value "dusk"
execute if score $tp_t macroengine.tmp matches 13800..23999 run data modify storage macroengine:output phase set value "night"
