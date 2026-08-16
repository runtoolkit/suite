tellraw @a[tag=macroengine.debug] {"text":"[DEBUG] Event system test starting...","color":"yellow"}

data modify storage macroengine:input event set value "on_join"
data modify storage macroengine:input func set value "macroengine:debug/internal/on_join_handler"
function macroengine:events/register with storage macroengine:input {}

data modify storage macroengine:input event set value "on_kill"
data modify storage macroengine:input func set value "macroengine:debug/internal/on_kill_handler"
function macroengine:events/register with storage macroengine:input {}

data remove storage macroengine:engine event_context
data modify storage macroengine:engine event_context.player set value "TestPlayer"
data modify storage macroengine:engine event_context.reason set value "debug_test"

data modify storage macroengine:input event set value "on_join"
function macroengine:events/fire with storage macroengine:input {}
data remove storage macroengine:input event

tellraw @a[tag=macroengine.debug] {"text":"[DEBUG] example_events completed.","color":"green"}