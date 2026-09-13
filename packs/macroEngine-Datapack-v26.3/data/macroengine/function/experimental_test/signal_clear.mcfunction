# macroengine:experimental_test/signal_clear [INTERNAL]
# Scheduled 2 ticks after signal_fail_at / signal_accept_at — removes
# any redstone_block placed at the fail/accept test_block positions so
# repeated test runs don't leave stray redstone_blocks behind.
execute as @e[tag=macroengine.experimental.test_marker,limit=1,sort=nearest] at @s if block ~ ~ ~ minecraft:redstone_block run setblock ~ ~ ~ minecraft:air
execute as @e[tag=macroengine.experimental.test_marker,limit=1,sort=nearest] at @s if block ~1 ~ ~ minecraft:redstone_block run setblock ~1 ~ ~ minecraft:air
