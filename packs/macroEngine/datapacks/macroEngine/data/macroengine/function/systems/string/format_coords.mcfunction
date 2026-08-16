# ─────────────────────────────────────────────────────────────────
# macroengine:systems/string/format_coords
# Stores three integer coordinates in macroengine:output and exposes
# them for use in tellraw components.
#
#  Input : $(x) → X coordinate (integer)
#          $(y) → Y coordinate (integer)
#          $(z) → Z coordinate (integer)
#
# Output: macroengine:output x   → X int
#         macroengine:output y   → Y int
#         macroengine:output z   → Z int
#
# USAGE — embed the stored values directly in a tellraw:
#   function macroengine:systems/string/format_coords {x:100,y:64,z:-200}
#   tellraw @a ["",
#     {"text":"(","color":"gray"},
#     {"plain":true ,"storage":"macroengine:output","nbt":"x","color":"green"},
#     {"text":", ","color":"gray"},
#     {"plain":true ,"storage":"macroengine:output","nbt":"y","color":"green"},
#     {"text":", ","color":"gray"},
#     {"plain":true ,"storage":"macroengine:output","nbt":"z","color":"green"},
#     {"text":")","color":"gray"}
#   ]
#   → (100, 64, -200)
#
# NOTE: macroengine:output is shared — copy x/y/z to your own storage
#       before making other macroengine calls if you need them later.
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $fc_x macroengine.tmp $(x)
$scoreboard players set $fc_y macroengine.tmp $(y)
$scoreboard players set $fc_z macroengine.tmp $(z)

execute store result storage macroengine:output x int 1 run scoreboard players get $fc_x macroengine.tmp
execute store result storage macroengine:output y int 1 run scoreboard players get $fc_y macroengine.tmp
execute store result storage macroengine:output z int 1 run scoreboard players get $fc_z macroengine.tmp

tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"string/format_coords ","color":"aqua"},{"text":"(","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"x","color":"#aaffaa"},{"text":", ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"y","color":"#aaffaa"},{"text":", ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"z","color":"#aaffaa"},{"text":")","color":"#555555"}]
