execute as @a[scores={macro_menu=1..}] run function macro:menu
scoreboard players set @a[scores={macro_menu=1..}] macro_menu 0
scoreboard players enable @a[scores={macro_menu=-1..}] macro_menu

execute as @a[scores={macro_run=1..}] run function #macro:run
scoreboard players set @a[scores={macro_run=1..}] macro_run 0
scoreboard players enable @a[scores={macro_run=-1..}] macro_run

execute as @a[scores={macro_action=1..}] run function macro:api/trigger/internal/dispatch

function macro:api/interaction/internal/tick_scan

function macro:api/perm/trigger/internal/tick_start

function macro:api/wand/internal/tick_scan
function macro:systems/hook/internal/tick_scan

function macro:systems/geo/region_watch/internal/tick_scan