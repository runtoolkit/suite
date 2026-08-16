execute as @a[scores={macroengine_menu=1..}] run function macroengine:menu
scoreboard players set @a[scores={macroengine_menu=1..}] macroengine_menu 0
scoreboard players enable @a[scores={macroengine_menu=-1..}] macroengine_menu

execute as @a[scores={macroengine_run=1..}] run function #macroengine:admin/run
scoreboard players set @a[scores={macroengine_run=1..}] macroengine_run 0
scoreboard players enable @a[scores={macroengine_run=-1..}] macroengine_run

execute as @a[scores={macroengine_action=1..}] run function macroengine:core/internal/api/trigger/dispatch

function macroengine:core/internal/api/interaction/tick_scan

function macroengine:core/internal/api/perm/trigger/tick_start

function macroengine:core/internal/api/wand/tick_scan
function macroengine:core/internal/systems/hook/tick_scan

function macroengine:core/internal/systems/geo/region_watch/tick_scan
function macroengine:core/internal/api/cmd/freeze/tick