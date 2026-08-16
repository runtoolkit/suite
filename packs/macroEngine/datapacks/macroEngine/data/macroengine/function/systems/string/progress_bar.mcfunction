$scoreboard players set $pb1_seg macroengine.tmp $(current)
$scoreboard players set $pb1_max macroengine.tmp $(max)

execute if score $pb1_max macroengine.tmp matches ..0 run return fail

scoreboard players set $pb1_ten macroengine.tmp 10
scoreboard players operation $pb1_seg macroengine.tmp *= $pb1_ten macroengine.tmp
scoreboard players operation $pb1_seg macroengine.tmp /= $pb1_max macroengine.tmp

execute if score $pb1_seg macroengine.tmp matches ..0 run scoreboard players set $pb1_seg macroengine.tmp 0
execute if score $pb1_seg macroengine.tmp matches 10.. run scoreboard players set $pb1_seg macroengine.tmp 10

$execute if score $pb1_seg macroengine.tmp matches 0 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ░░░░░░░░░░"}
$execute if score $pb1_seg macroengine.tmp matches 1 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) █░░░░░░░░░"}
$execute if score $pb1_seg macroengine.tmp matches 2 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ██░░░░░░░░"}
$execute if score $pb1_seg macroengine.tmp matches 3 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ███░░░░░░░"}
$execute if score $pb1_seg macroengine.tmp matches 4 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ████░░░░░░"}
$execute if score $pb1_seg macroengine.tmp matches 5 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) █████░░░░░"}
$execute if score $pb1_seg macroengine.tmp matches 6 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ██████░░░░"}
$execute if score $pb1_seg macroengine.tmp matches 7 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ███████░░░"}
$execute if score $pb1_seg macroengine.tmp matches 8 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ████████░░"}
$execute if score $pb1_seg macroengine.tmp matches 9 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) █████████░"}
$execute if score $pb1_seg macroengine.tmp matches 10 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ██████████"}
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"string/progress_bar ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(label)","color":"aqua"}]
