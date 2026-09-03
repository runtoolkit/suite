# macroengine:systems/math/atan2 [MACRO]
# Integer atan2 — returns angle in degrees × 1000 (range: -180000..180000)
# Uses octant decomposition + lookup table (same scale as sin/cos: ×1000)
#
# INPUT:  $(y), $(x)  — integer coordinates (scaled consistently)
# OUTPUT: macroengine:output result — degrees × 1000
#
# EXAMPLE:
# function macroengine:systems/math/atan2 {y:500, x:500}
# → result = 45000 (45.000°)
#
# NOTES:
# - Both x and y zero → result = 0
# - Result matches standard math convention (CCW from +X axis)

$scoreboard players set $a2_y macroengine.tmp $(y)
$scoreboard players set $a2_x macroengine.tmp $(x)

# Determine quadrant sign flags
scoreboard players set $a2_sx macroengine.tmp 1
scoreboard players set $a2_sy macroengine.tmp 1
execute if score $a2_x macroengine.tmp matches ..-1 run scoreboard players set $a2_sx macroengine.tmp -1
execute if score $a2_y macroengine.tmp matches ..-1 run scoreboard players set $a2_sy macroengine.tmp -1

# Work in absolute values
scoreboard players set $a2_ax macroengine.tmp 0
scoreboard players set $a2_ay macroengine.tmp 0
execute store result score $a2_ax macroengine.tmp run scoreboard players get $a2_x macroengine.tmp
execute if score $a2_ax macroengine.tmp matches ..-1 run scoreboard players operation $a2_ax macroengine.tmp *= $a2_sx macroengine.tmp
execute store result score $a2_ay macroengine.tmp run scoreboard players get $a2_y macroengine.tmp
execute if score $a2_ay macroengine.tmp matches ..-1 run scoreboard players operation $a2_ay macroengine.tmp *= $a2_sy macroengine.tmp

# Handle degenerate cases
execute if score $a2_ax macroengine.tmp matches 0 if score $a2_ay macroengine.tmp matches 0 run data modify storage macroengine:output result set value 0
execute if score $a2_ax macroengine.tmp matches 0 if score $a2_ay macroengine.tmp matches 0 run return 0

execute if score $a2_ax macroengine.tmp matches 0 if score $a2_sy macroengine.tmp matches 1 run data modify storage macroengine:output result set value 90000
execute if score $a2_ax macroengine.tmp matches 0 if score $a2_sy macroengine.tmp matches 1 run return 0
execute if score $a2_ax macroengine.tmp matches 0 if score $a2_sy macroengine.tmp matches -1 run data modify storage macroengine:output result set value -90000
execute if score $a2_ax macroengine.tmp matches 0 if score $a2_sy macroengine.tmp matches -1 run return 0

execute if score $a2_ay macroengine.tmp matches 0 if score $a2_sx macroengine.tmp matches 1 run data modify storage macroengine:output result set value 0
execute if score $a2_ay macroengine.tmp matches 0 if score $a2_sx macroengine.tmp matches 1 run return 0
execute if score $a2_ay macroengine.tmp matches 0 if score $a2_sx macroengine.tmp matches -1 run data modify storage macroengine:output result set value 180000
execute if score $a2_ay macroengine.tmp matches 0 if score $a2_sx macroengine.tmp matches -1 run return 0

# Compute ratio = (min/max) × 100 → 0..100 mapped to 0..45°
# Swap so we always divide smaller by larger (→ octant 0..45°)
scoreboard players set $a2_swap macroengine.tmp 0
execute if score $a2_ay macroengine.tmp > $a2_ax macroengine.tmp run scoreboard players set $a2_swap macroengine.tmp 1
execute if score $a2_swap macroengine.tmp matches 1 run scoreboard players operation $a2_ax macroengine.tmp >< $a2_ay macroengine.tmp

# ratio = ay*100 / ax (ay ≤ ax here)
scoreboard players set $a2_100 macroengine.tmp 100
scoreboard players operation $a2_ay macroengine.tmp *= $a2_100 macroengine.tmp
scoreboard players operation $a2_ay macroengine.tmp /= $a2_ax macroengine.tmp

# Lookup table: ratio 0-100 → atan(ratio/100) × 1000 in degrees
execute if score $a2_ay macroengine.tmp matches 0 run scoreboard players set $a2_r macroengine.tmp 0
execute if score $a2_ay macroengine.tmp matches 1 run scoreboard players set $a2_r macroengine.tmp 573
execute if score $a2_ay macroengine.tmp matches 2 run scoreboard players set $a2_r macroengine.tmp 1146
execute if score $a2_ay macroengine.tmp matches 3 run scoreboard players set $a2_r macroengine.tmp 1718
execute if score $a2_ay macroengine.tmp matches 4 run scoreboard players set $a2_r macroengine.tmp 2291
execute if score $a2_ay macroengine.tmp matches 5 run scoreboard players set $a2_r macroengine.tmp 2862
execute if score $a2_ay macroengine.tmp matches 6 run scoreboard players set $a2_r macroengine.tmp 3433
execute if score $a2_ay macroengine.tmp matches 7 run scoreboard players set $a2_r macroengine.tmp 4004
execute if score $a2_ay macroengine.tmp matches 8 run scoreboard players set $a2_r macroengine.tmp 4574
execute if score $a2_ay macroengine.tmp matches 9 run scoreboard players set $a2_r macroengine.tmp 5143
execute if score $a2_ay macroengine.tmp matches 10 run scoreboard players set $a2_r macroengine.tmp 5711
execute if score $a2_ay macroengine.tmp matches 11 run scoreboard players set $a2_r macroengine.tmp 6279
execute if score $a2_ay macroengine.tmp matches 12 run scoreboard players set $a2_r macroengine.tmp 6843
execute if score $a2_ay macroengine.tmp matches 13 run scoreboard players set $a2_r macroengine.tmp 7407
execute if score $a2_ay macroengine.tmp matches 14 run scoreboard players set $a2_r macroengine.tmp 7969
execute if score $a2_ay macroengine.tmp matches 15 run scoreboard players set $a2_r macroengine.tmp 8531
execute if score $a2_ay macroengine.tmp matches 16 run scoreboard players set $a2_r macroengine.tmp 9090
execute if score $a2_ay macroengine.tmp matches 17 run scoreboard players set $a2_r macroengine.tmp 9649
execute if score $a2_ay macroengine.tmp matches 18 run scoreboard players set $a2_r macroengine.tmp 10205
execute if score $a2_ay macroengine.tmp matches 19 run scoreboard players set $a2_r macroengine.tmp 10760
execute if score $a2_ay macroengine.tmp matches 20 run scoreboard players set $a2_r macroengine.tmp 11310
execute if score $a2_ay macroengine.tmp matches 21 run scoreboard players set $a2_r macroengine.tmp 11860
execute if score $a2_ay macroengine.tmp matches 22 run scoreboard players set $a2_r macroengine.tmp 12407
execute if score $a2_ay macroengine.tmp matches 23 run scoreboard players set $a2_r macroengine.tmp 12951
execute if score $a2_ay macroengine.tmp matches 24 run scoreboard players set $a2_r macroengine.tmp 13495
execute if score $a2_ay macroengine.tmp matches 25 run scoreboard players set $a2_r macroengine.tmp 14036
execute if score $a2_ay macroengine.tmp matches 26 run scoreboard players set $a2_r macroengine.tmp 14574
execute if score $a2_ay macroengine.tmp matches 27 run scoreboard players set $a2_r macroengine.tmp 15111
execute if score $a2_ay macroengine.tmp matches 28 run scoreboard players set $a2_r macroengine.tmp 15643
execute if score $a2_ay macroengine.tmp matches 29 run scoreboard players set $a2_r macroengine.tmp 16174
execute if score $a2_ay macroengine.tmp matches 30 run scoreboard players set $a2_r macroengine.tmp 16699
execute if score $a2_ay macroengine.tmp matches 31 run scoreboard players set $a2_r macroengine.tmp 17223
execute if score $a2_ay macroengine.tmp matches 32 run scoreboard players set $a2_r macroengine.tmp 17744
execute if score $a2_ay macroengine.tmp matches 33 run scoreboard players set $a2_r macroengine.tmp 18263
execute if score $a2_ay macroengine.tmp matches 34 run scoreboard players set $a2_r macroengine.tmp 18778
execute if score $a2_ay macroengine.tmp matches 35 run scoreboard players set $a2_r macroengine.tmp 19290
execute if score $a2_ay macroengine.tmp matches 36 run scoreboard players set $a2_r macroengine.tmp 19799
execute if score $a2_ay macroengine.tmp matches 37 run scoreboard players set $a2_r macroengine.tmp 20304
execute if score $a2_ay macroengine.tmp matches 38 run scoreboard players set $a2_r macroengine.tmp 20806
execute if score $a2_ay macroengine.tmp matches 39 run scoreboard players set $a2_r macroengine.tmp 21304
execute if score $a2_ay macroengine.tmp matches 40 run scoreboard players set $a2_r macroengine.tmp 21801
execute if score $a2_ay macroengine.tmp matches 41 run scoreboard players set $a2_r macroengine.tmp 22292
execute if score $a2_ay macroengine.tmp matches 42 run scoreboard players set $a2_r macroengine.tmp 22782
execute if score $a2_ay macroengine.tmp matches 43 run scoreboard players set $a2_r macroengine.tmp 23268
execute if score $a2_ay macroengine.tmp matches 44 run scoreboard players set $a2_r macroengine.tmp 23749
execute if score $a2_ay macroengine.tmp matches 45 run scoreboard players set $a2_r macroengine.tmp 24228
execute if score $a2_ay macroengine.tmp matches 46 run scoreboard players set $a2_r macroengine.tmp 24703
execute if score $a2_ay macroengine.tmp matches 47 run scoreboard players set $a2_r macroengine.tmp 25174
execute if score $a2_ay macroengine.tmp matches 48 run scoreboard players set $a2_r macroengine.tmp 25642
execute if score $a2_ay macroengine.tmp matches 49 run scoreboard players set $a2_r macroengine.tmp 26105
execute if score $a2_ay macroengine.tmp matches 50 run scoreboard players set $a2_r macroengine.tmp 26565
execute if score $a2_ay macroengine.tmp matches 51 run scoreboard players set $a2_r macroengine.tmp 27021
execute if score $a2_ay macroengine.tmp matches 52 run scoreboard players set $a2_r macroengine.tmp 27473
execute if score $a2_ay macroengine.tmp matches 53 run scoreboard players set $a2_r macroengine.tmp 27922
execute if score $a2_ay macroengine.tmp matches 54 run scoreboard players set $a2_r macroengine.tmp 28367
execute if score $a2_ay macroengine.tmp matches 55 run scoreboard players set $a2_r macroengine.tmp 28808
execute if score $a2_ay macroengine.tmp matches 56 run scoreboard players set $a2_r macroengine.tmp 29145
execute if score $a2_ay macroengine.tmp matches 57 run scoreboard players set $a2_r macroengine.tmp 29678
execute if score $a2_ay macroengine.tmp matches 58 run scoreboard players set $a2_r macroengine.tmp 30107
execute if score $a2_ay macroengine.tmp matches 59 run scoreboard players set $a2_r macroengine.tmp 30531
execute if score $a2_ay macroengine.tmp matches 60 run scoreboard players set $a2_r macroengine.tmp 30964
execute if score $a2_ay macroengine.tmp matches 61 run scoreboard players set $a2_r macroengine.tmp 31333
execute if score $a2_ay macroengine.tmp matches 62 run scoreboard players set $a2_r macroengine.tmp 31759
execute if score $a2_ay macroengine.tmp matches 63 run scoreboard players set $a2_r macroengine.tmp 32175
execute if score $a2_ay macroengine.tmp matches 64 run scoreboard players set $a2_r macroengine.tmp 32619
execute if score $a2_ay macroengine.tmp matches 65 run scoreboard players set $a2_r macroengine.tmp 33001
execute if score $a2_ay macroengine.tmp matches 66 run scoreboard players set $a2_r macroengine.tmp 33401
execute if score $a2_ay macroengine.tmp matches 67 run scoreboard players set $a2_r macroengine.tmp 33801
execute if score $a2_ay macroengine.tmp matches 68 run scoreboard players set $a2_r macroengine.tmp 34200
execute if score $a2_ay macroengine.tmp matches 69 run scoreboard players set $a2_r macroengine.tmp 34596
execute if score $a2_ay macroengine.tmp matches 70 run scoreboard players set $a2_r macroengine.tmp 34992
execute if score $a2_ay macroengine.tmp matches 71 run scoreboard players set $a2_r macroengine.tmp 35384
execute if score $a2_ay macroengine.tmp matches 72 run scoreboard players set $a2_r macroengine.tmp 35757
execute if score $a2_ay macroengine.tmp matches 73 run scoreboard players set $a2_r macroengine.tmp 36161
execute if score $a2_ay macroengine.tmp matches 74 run scoreboard players set $a2_r macroengine.tmp 36541
execute if score $a2_ay macroengine.tmp matches 75 run scoreboard players set $a2_r macroengine.tmp 36920
execute if score $a2_ay macroengine.tmp matches 76 run scoreboard players set $a2_r macroengine.tmp 37297
execute if score $a2_ay macroengine.tmp matches 77 run scoreboard players set $a2_r macroengine.tmp 37672
execute if score $a2_ay macroengine.tmp matches 78 run scoreboard players set $a2_r macroengine.tmp 38045
execute if score $a2_ay macroengine.tmp matches 79 run scoreboard players set $a2_r macroengine.tmp 38416
execute if score $a2_ay macroengine.tmp matches 80 run scoreboard players set $a2_r macroengine.tmp 38785
execute if score $a2_ay macroengine.tmp matches 81 run scoreboard players set $a2_r macroengine.tmp 39151
execute if score $a2_ay macroengine.tmp matches 82 run scoreboard players set $a2_r macroengine.tmp 39516
execute if score $a2_ay macroengine.tmp matches 83 run scoreboard players set $a2_r macroengine.tmp 39878
execute if score $a2_ay macroengine.tmp matches 84 run scoreboard players set $a2_r macroengine.tmp 40236
execute if score $a2_ay macroengine.tmp matches 85 run scoreboard players set $a2_r macroengine.tmp 40593
execute if score $a2_ay macroengine.tmp matches 86 run scoreboard players set $a2_r macroengine.tmp 40948
execute if score $a2_ay macroengine.tmp matches 87 run scoreboard players set $a2_r macroengine.tmp 41301
execute if score $a2_ay macroengine.tmp matches 88 run scoreboard players set $a2_r macroengine.tmp 41634
execute if score $a2_ay macroengine.tmp matches 89 run scoreboard players set $a2_r macroengine.tmp 41996
execute if score $a2_ay macroengine.tmp matches 90 run scoreboard players set $a2_r macroengine.tmp 42274
execute if score $a2_ay macroengine.tmp matches 91 run scoreboard players set $a2_r macroengine.tmp 42620
execute if score $a2_ay macroengine.tmp matches 92 run scoreboard players set $a2_r macroengine.tmp 42965
execute if score $a2_ay macroengine.tmp matches 93 run scoreboard players set $a2_r macroengine.tmp 43307
execute if score $a2_ay macroengine.tmp matches 94 run scoreboard players set $a2_r macroengine.tmp 43648
execute if score $a2_ay macroengine.tmp matches 95 run scoreboard players set $a2_r macroengine.tmp 43565
execute if score $a2_ay macroengine.tmp matches 96 run scoreboard players set $a2_r macroengine.tmp 44321
execute if score $a2_ay macroengine.tmp matches 97 run scoreboard players set $a2_r macroengine.tmp 44659
execute if score $a2_ay macroengine.tmp matches 98 run scoreboard players set $a2_r macroengine.tmp 44996
execute if score $a2_ay macroengine.tmp matches 99 run scoreboard players set $a2_r macroengine.tmp 44731
execute if score $a2_ay macroengine.tmp matches 100 run scoreboard players set $a2_r macroengine.tmp 45000

# Undo swap: if swapped, angle = 90000 - angle
execute if score $a2_swap macroengine.tmp matches 1 run scoreboard players set $a2_90 macroengine.tmp 90000
execute if score $a2_swap macroengine.tmp matches 1 run scoreboard players operation $a2_90 macroengine.tmp -= $a2_r macroengine.tmp
execute if score $a2_swap macroengine.tmp matches 1 run scoreboard players operation $a2_r macroengine.tmp = $a2_90 macroengine.tmp

# Apply quadrant offsets
# Q2 (x<0, y≥0): angle = 180000 - angle
execute if score $a2_sx macroengine.tmp matches -1 if score $a2_sy macroengine.tmp matches 1 run scoreboard players set $a2_180 macroengine.tmp 180000
execute if score $a2_sx macroengine.tmp matches -1 if score $a2_sy macroengine.tmp matches 1 run scoreboard players operation $a2_180 macroengine.tmp -= $a2_r macroengine.tmp
execute if score $a2_sx macroengine.tmp matches -1 if score $a2_sy macroengine.tmp matches 1 run scoreboard players operation $a2_r macroengine.tmp = $a2_180 macroengine.tmp

# Q3 (x<0, y<0): angle = -(180000 - angle) → angle - 180000
execute if score $a2_sx macroengine.tmp matches -1 if score $a2_sy macroengine.tmp matches -1 run scoreboard players set $a2_180 macroengine.tmp 180000
execute if score $a2_sx macroengine.tmp matches -1 if score $a2_sy macroengine.tmp matches -1 run scoreboard players operation $a2_180 macroengine.tmp -= $a2_r macroengine.tmp
execute if score $a2_sx macroengine.tmp matches -1 if score $a2_sy macroengine.tmp matches -1 run scoreboard players set $a2_neg macroengine.tmp 0
execute if score $a2_sx macroengine.tmp matches -1 if score $a2_sy macroengine.tmp matches -1 run scoreboard players operation $a2_neg macroengine.tmp -= $a2_180 macroengine.tmp
execute if score $a2_sx macroengine.tmp matches -1 if score $a2_sy macroengine.tmp matches -1 run scoreboard players operation $a2_r macroengine.tmp = $a2_neg macroengine.tmp

# Q4 (x≥0, y<0): angle = -angle
execute if score $a2_sx macroengine.tmp matches 1 if score $a2_sy macroengine.tmp matches -1 run scoreboard players set $a2_neg macroengine.tmp 0
execute if score $a2_sx macroengine.tmp matches 1 if score $a2_sy macroengine.tmp matches -1 run scoreboard players operation $a2_neg macroengine.tmp -= $a2_r macroengine.tmp
execute if score $a2_sx macroengine.tmp matches 1 if score $a2_sy macroengine.tmp matches -1 run scoreboard players operation $a2_r macroengine.tmp = $a2_neg macroengine.tmp

execute store result storage macroengine:output result int 1 run scoreboard players get $a2_r macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/atan2 ","color":"aqua"},{"text":"y=$(y) x=$(x) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"},{"text":"/1000°","color":"#555555"}]
