execute as @a[scores={macroengine_menu=1..}] run function macroengine:menu
scoreboard players set @a[scores={macroengine_menu=1..}] macroengine_menu 0
scoreboard players enable @a[scores={macroengine_menu=-1..}] macroengine_menu

execute as @a[scores={macroengine_run=1..}] run function #macroengine:admin/run
scoreboard players set @a[scores={macroengine_run=1..}] macroengine_run 0
scoreboard players enable @a[scores={macroengine_run=-1..}] macroengine_run

execute as @a[scores={macroengine_action=1..}] run function macroengine:core/internal/api/trigger/dispatch

function macroengine:core/internal/api/interaction/tick_scan

function macroengine:core/internal/api/perm/trigger/tick_start

scoreboard players remove @a[scores={macroengine.dialog_load=1..}] macroengine.dialog_load 1

# Countdown actionbar: show remaining ticks while dialog is loading
#execute as @a[scores={macroengine.dialog_load=1..},tag=macroengine.dialog_opened,tag=!macroengine.dialog_closed] run title @s actionbar ["",{"text":"Loading ","color":"aqua","bold":true},{"score":{"name":"@s","objective":"macroengine.dialog_load"},"color":"yellow","bold":true},{"text":" ticks","color":"gray"}]
execute as @a[scores={macroengine.dialog_load=1..}] run title @s actionbar ["",{"text":"Loading ","color":"aqua","bold":true},{"score":{"name":"@s","objective":"macroengine.dialog_load"},"color":"yellow","bold":true},{"text":" ticks","color":"gray"}]

execute as @a[scores={macroengine.dialog_load=0},tag=macroengine.dialog_closed] at @s run function macroengine:api/dialog/open
execute as @a[scores={macroengine.dialog_load=0},tag=!macroengine.dialog_closed,tag=!macroengine.dialog_opened] at @s run function macroengine:api/dialog/open

function macroengine:core/internal/api/wand/tick_scan
function macroengine:core/internal/systems/hook/tick_scan

function macroengine:core/internal/systems/geo/region_watch/tick_scan
function macroengine:core/internal/api/cmd/freeze/tick