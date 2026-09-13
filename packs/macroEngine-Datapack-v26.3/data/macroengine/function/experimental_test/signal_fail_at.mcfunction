# macroengine:experimental_test/signal_fail_at [INTERNAL]
# Run `as`/`at` the test_marker armor stand. The fail test_block sits
# directly below the marker's spawn point (local offset 1,1,0 -> block
# at 1,0,0), so this checks one block down.
execute if block ~ ~-1 ~ minecraft:test_block[mode=fail] run setblock ~ ~ ~ minecraft:redstone_block
schedule function macroengine:experimental_test/signal_clear 2t
