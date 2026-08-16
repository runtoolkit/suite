$scoreboard players set $pbs_max macroengine.tmp $(pb_max)
execute if score $pbs_max macroengine.tmp matches ..0 run return fail

$execute store result score $pbs_seg macroengine.tmp run scoreboard players get @s $(pb_obj)

scoreboard players set $pbs_ten macroengine.tmp 10
scoreboard players operation $pbs_seg macroengine.tmp *= $pbs_ten macroengine.tmp
scoreboard players operation $pbs_seg macroengine.tmp /= $pbs_max macroengine.tmp

execute if score $pbs_seg macroengine.tmp matches ..0 run scoreboard players set $pbs_seg macroengine.tmp 0
execute if score $pbs_seg macroengine.tmp matches 10.. run scoreboard players set $pbs_seg macroengine.tmp 10

$execute if score $pbs_seg macroengine.tmp matches 0 run title @s actionbar {"text":"$(pb_label) ░░░░░░░░░░"}
$execute if score $pbs_seg macroengine.tmp matches 1 run title @s actionbar {"text":"$(pb_label) █░░░░░░░░░"}
$execute if score $pbs_seg macroengine.tmp matches 2 run title @s actionbar {"text":"$(pb_label) ██░░░░░░░░"}
$execute if score $pbs_seg macroengine.tmp matches 3 run title @s actionbar {"text":"$(pb_label) ███░░░░░░░"}
$execute if score $pbs_seg macroengine.tmp matches 4 run title @s actionbar {"text":"$(pb_label) ████░░░░░░"}
$execute if score $pbs_seg macroengine.tmp matches 5 run title @s actionbar {"text":"$(pb_label) █████░░░░░"}
$execute if score $pbs_seg macroengine.tmp matches 6 run title @s actionbar {"text":"$(pb_label) ██████░░░░"}
$execute if score $pbs_seg macroengine.tmp matches 7 run title @s actionbar {"text":"$(pb_label) ███████░░░"}
$execute if score $pbs_seg macroengine.tmp matches 8 run title @s actionbar {"text":"$(pb_label) ████████░░"}
$execute if score $pbs_seg macroengine.tmp matches 9 run title @s actionbar {"text":"$(pb_label) █████████░"}
$execute if score $pbs_seg macroengine.tmp matches 10 run title @s actionbar {"text":"$(pb_label) ██████████"}
