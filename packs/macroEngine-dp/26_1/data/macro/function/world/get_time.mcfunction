# ─────────────────────────────────────────────────────────────────
# macro:world/get_time
# Compatible with 26.1+ World Clocks (minecraft:overworld)
#
# OUTPUT:
# macro:output.daytime → in-day time (0-23999)
# macro:output.total → total world age (gametime)
# macro:output.day → current day number
# ─────────────────────────────────────────────────────────────────

execute store result storage macro:output daytime int 1 run time of minecraft:overworld query day
execute store result storage macro:output total int 1 run time query gametime
execute store result storage macro:output day int 1 run time of minecraft:overworld query day repetition

# Debug (optional)
tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"world/get_time ","color":"aqua"},{"text":"day=","color":"gray"},{"storage":"macro:output","nbt":"day","color":"green"},{"text":" daytime=","color":"gray"},{"storage":"macro:output","nbt":"daytime","color":"green"},{"text":" total=","color":"gray"},{"storage":"macro:output","nbt":"total","color":"green"}]
