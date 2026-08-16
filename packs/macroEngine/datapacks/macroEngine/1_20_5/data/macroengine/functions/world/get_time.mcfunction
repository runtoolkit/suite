# ─────────────────────────────────────────────────────────────────
# macroengine:world/get_time
# Compatible with 26.3-snapshot-5+ World Clocks (minecraft:overworld)
#
# OUTPUT:
# macroengine:output.daytime → in-day time (0-23999)
# macroengine:output.total → total world age (gametime)
# macroengine:output.day → current day number
# ─────────────────────────────────────────────────────────────────

execute store result storage macroengine:output daytime int 1 run time query daytime
execute store result storage macroengine:output total int 1 run time query gametime
execute store result storage macroengine:output day int 1 run time query day

# Debug (optional)
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"world/get_time ","color":"aqua"},{"text":"day=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"day","color":"green"},{"text":" daytime=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"daytime","color":"green"},{"text":" total=","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"total","color":"green"}]
