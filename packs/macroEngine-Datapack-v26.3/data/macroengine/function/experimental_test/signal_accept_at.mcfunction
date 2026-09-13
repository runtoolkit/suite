# macroengine:experimental_test/signal_accept_at [INTERNAL]
# Run `as`/`at` the test_marker armor stand. The accept test_block is
# one block east (+x) of the fail block, at the same height as the
# fail block (one below the marker's spawn point).
execute if block ~1 ~-1 ~ minecraft:test_block[mode=accept] run setblock ~1 ~ ~ minecraft:redstone_block
schedule function macroengine:experimental_test/signal_clear 2t
