# macroengine:experimental_test/check/waypoint [INTERNAL]
# Verifies experimental/waypoint/set actually stores a waypoint under
# the given name.

data modify storage macroengine:engine flags.experimental.waypoint set value 1b
data remove storage macroengine:engine waypoints.macroengine_test_wp

function macroengine:experimental/waypoint/set {name:"macroengine_test_wp"}
execute unless data storage macroengine:engine waypoints.macroengine_test_wp run function macroengine:experimental_test/signal {result:"fail"}
execute if data storage macroengine:engine waypoints.macroengine_test_wp run function macroengine:experimental_test/signal {result:"accept"}

data remove storage macroengine:engine waypoints.macroengine_test_wp
data modify storage macroengine:engine flags.experimental.waypoint set value 0b
