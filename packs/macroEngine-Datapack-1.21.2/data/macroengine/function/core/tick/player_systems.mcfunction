execute as @a[scores={macroengine_menu=1..}] run function macroengine:menu
scoreboard players set @a[scores={macroengine_menu=1..}] macroengine_menu 0
scoreboard players enable @a[scores={macroengine_menu=-1..}] macroengine_menu

execute as @a[scores={macroengine_run=1..}] run function #macroengine:admin/run
scoreboard players set @a[scores={macroengine_run=1..}] macroengine_run 0
scoreboard players enable @a[scores={macroengine_run=-1..}] macroengine_run

execute as @a[scores={macroengine_action=1..}] run function macroengine:core/internal/api/trigger/dispatch

function macroengine:core/internal/api/interaction/tick_scan

function macroengine:core/internal/api/perm/trigger/tick_start

# BACKPORT NOTE (1.21.2): removed the dialog-loading countdown block that
# lived here (macroengine.dialog_load tick-down + actionbar + calls into
# macroengine:api/dialog/open). It only existed to drive the native dialog
# system, which does not exist in 1.21.2 — see setup/open_screen.mcfunction
# and api/toggle/show.mcfunction for the chat-menu replacement.

function macroengine:core/internal/api/wand/tick_scan
function macroengine:core/internal/systems/hook/tick_scan

function macroengine:core/internal/systems/geo/region_watch/tick_scan
function macroengine:core/internal/api/cmd/freeze/tick

# Experimental features (see systems/flag/experimental) — each is a
# no-op unless its own flag is on, checked internally by the callee.
function macroengine:experimental/particle_trail/tick
function macroengine:experimental/combat_tag/tick