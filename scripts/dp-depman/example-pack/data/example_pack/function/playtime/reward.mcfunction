# example_pack:playtime/reward
# Gives a one-time reward at 1 hour playtime, then resets the counter.

give @s minecraft:diamond 1
tellraw @s {"text":"You earned a diamond for 1 hour of playtime!","color":"aqua"}

# Reset counter so the reward fires again at the next 1-hour mark
scoreboard players set @s ep.playtime 0
