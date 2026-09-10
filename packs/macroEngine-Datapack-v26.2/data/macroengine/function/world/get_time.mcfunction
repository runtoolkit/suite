# macroengine:world/get_time — 26.3 World Clocks
execute store result storage macroengine:output daytime int 1 run time query minecraft:day
execute store result storage macroengine:output total int 1 run time query gametime
execute store result storage macroengine:output day int 1 run time query minecraft:day repetition
