# example_pack:playtime/check
# Executed as each player (@a). Awards a diamond at 1 hour of playtime.
# ep.playtime tracks ticks played (20 ticks/sec × 60 sec × 60 min = 72000).

execute if score @s ep.playtime matches 72000.. run function example_pack:playtime/reward
