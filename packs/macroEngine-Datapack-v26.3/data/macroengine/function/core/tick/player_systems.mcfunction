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

# BACKPORT/FIX NOTE: the old cleanup line here used
#   kill @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{macroengine:{input:1b}}}}}]
# nbt= cannot match into Item.components (component maps aren't NBT tags,
# not since 1.20.5) — this selector matched nothing on every version we
# support, so the marker items were never actually being killed here.
# Replaced with a predicate match against macroengine:is_input_marker
# (data/macroengine/predicate/is_input_marker.json), which checks
# minecraft:custom_data via minecraft:matches_item / entity_properties.
kill @e[type=minecraft:item,predicate=macroengine:is_input_marker]
