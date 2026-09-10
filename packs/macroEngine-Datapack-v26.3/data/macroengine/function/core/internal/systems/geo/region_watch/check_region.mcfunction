# macroengine:systems/geo/region_watch/internal/check_region [MACRO]
# INPUT (from _rw_cur): $(id), $(x1), $(y1), $(z1), $(x2), $(y2), $(z2)
# @s = the player being checked
# Player coordinates: macroengine:engine _rw_player.{x,y,z}

# --- AABB test: return early if outside any axis ---
execute store result score $rwx macroengine.tmp run data get storage macroengine:engine _rw_player.x
execute store result score $rwy macroengine.tmp run data get storage macroengine:engine _rw_player.y
execute store result score $rwz macroengine.tmp run data get storage macroengine:engine _rw_player.z

$scoreboard players set $rwx1 macroengine.tmp $(x1)
$scoreboard players set $rwy1 macroengine.tmp $(y1)
$scoreboard players set $rwz1 macroengine.tmp $(z1)
$scoreboard players set $rwx2 macroengine.tmp $(x2)
$scoreboard players set $rwy2 macroengine.tmp $(y2)
$scoreboard players set $rwz2 macroengine.tmp $(z2)

# min/max normalize
execute if score $rwx1 macroengine.tmp > $rwx2 macroengine.tmp run scoreboard players operation $rwt macroengine.tmp = $rwx1 macroengine.tmp
execute if score $rwx1 macroengine.tmp > $rwx2 macroengine.tmp run scoreboard players operation $rwx1 macroengine.tmp = $rwx2 macroengine.tmp
execute if score $rwt macroengine.tmp > $rwx2 macroengine.tmp run scoreboard players operation $rwx2 macroengine.tmp = $rwt macroengine.tmp
execute if score $rwy1 macroengine.tmp > $rwy2 macroengine.tmp run scoreboard players operation $rwt macroengine.tmp = $rwy1 macroengine.tmp
execute if score $rwy1 macroengine.tmp > $rwy2 macroengine.tmp run scoreboard players operation $rwy1 macroengine.tmp = $rwy2 macroengine.tmp
execute if score $rwt macroengine.tmp > $rwy2 macroengine.tmp run scoreboard players operation $rwy2 macroengine.tmp = $rwt macroengine.tmp
execute if score $rwz1 macroengine.tmp > $rwz2 macroengine.tmp run scoreboard players operation $rwt macroengine.tmp = $rwz1 macroengine.tmp
execute if score $rwz1 macroengine.tmp > $rwz2 macroengine.tmp run scoreboard players operation $rwz1 macroengine.tmp = $rwz2 macroengine.tmp
execute if score $rwt macroengine.tmp > $rwz2 macroengine.tmp run scoreboard players operation $rwz2 macroengine.tmp = $rwt macroengine.tmp

# Inside AABB? 1=inside, 0=outside
scoreboard players set $rw_inside macroengine.tmp 1
execute if score $rwx macroengine.tmp < $rwx1 macroengine.tmp run scoreboard players set $rw_inside macroengine.tmp 0
execute if score $rwx macroengine.tmp > $rwx2 macroengine.tmp run scoreboard players set $rw_inside macroengine.tmp 0
execute if score $rwy macroengine.tmp < $rwy1 macroengine.tmp run scoreboard players set $rw_inside macroengine.tmp 0
execute if score $rwy macroengine.tmp > $rwy2 macroengine.tmp run scoreboard players set $rw_inside macroengine.tmp 0
execute if score $rwz macroengine.tmp < $rwz1 macroengine.tmp run scoreboard players set $rw_inside macroengine.tmp 0
execute if score $rwz macroengine.tmp > $rwz2 macroengine.tmp run scoreboard players set $rw_inside macroengine.tmp 0

# --- State transition ---
# Was inside and still inside → do nothing
$execute if score $rw_inside macroengine.tmp matches 1 run execute if entity @s[tag=rw.$(id)] run return 0
# Was outside and still outside → do nothing
$execute if score $rw_inside macroengine.tmp matches 0 run execute unless entity @s[tag=rw.$(id)] run return 0

# --- on_enter: was outside, now inside ---
$execute if score $rw_inside macroengine.tmp matches 1 run tag @s add rw.$(id)
# DOT NOTATION: _rw_cur.on_enter (space-separated subpath is invalid)
execute if score $rw_inside macroengine.tmp matches 1 run execute if data storage macroengine:engine _rw_cur.on_enter run function macroengine:core/internal/systems/geo/region_watch/fire_enter with storage macroengine:engine _rw_cur
execute if score $rw_inside macroengine.tmp matches 1 run execute if data storage macroengine:engine _rw_cur.on_enter_cmd run function macroengine:core/internal/systems/geo/region_watch/fire_enter_cmd with storage macroengine:engine _rw_cur
execute if score $rw_inside macroengine.tmp matches 1 run return 0

# --- on_leave: was inside, now outside ---
$tag @s remove rw.$(id)
execute if data storage macroengine:engine _rw_cur.on_leave run function macroengine:core/internal/systems/geo/region_watch/fire_leave with storage macroengine:engine _rw_cur
execute if data storage macroengine:engine _rw_cur.on_leave_cmd run function macroengine:core/internal/systems/geo/region_watch/fire_leave_cmd with storage macroengine:engine _rw_cur
