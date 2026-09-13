# macroengine:experimental_test/signal [MACRO] [INTERNAL]
# Positions at the nearest macroengine.experimental.test_marker armor
# stand (baked into structure macroengine:test/experimental_check),
# then signals fail or accept depending on $(result). Works no matter
# where in the world the test structure was placed.
#
# Usage:  function macroengine:experimental_test/signal {result:"accept"}
#         (result must be exactly "fail" or "accept")
# Caller: any (internal helper; no-op if no marker is nearby)

$data modify storage macroengine:engine _test_signal_result set value "$(result)"
execute as @e[tag=macroengine.experimental.test_marker,limit=1,sort=nearest] at @s if data storage macroengine:engine {_test_signal_result:"fail"} run function macroengine:experimental_test/signal_fail_at
execute as @e[tag=macroengine.experimental.test_marker,limit=1,sort=nearest] at @s if data storage macroengine:engine {_test_signal_result:"accept"} run function macroengine:experimental_test/signal_accept_at
data remove storage macroengine:engine _test_signal_result
